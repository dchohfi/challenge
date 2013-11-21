//
// Created by Diego Chohfi on 11/21/13.
// Copyright (c) 2013 Diego Chohfi. All rights reserved.
//


#import "DCPersistenceHelper.h"

@interface DCPersistenceHelper()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSURL *modelURL;
@property (nonatomic, strong) NSURL *storeURL;

@end


@implementation DCPersistenceHelper

- (id)initWithStoreURL: (NSURL *)storeURL modelURL: (NSURL *) modelURL{
    self = [super init];
    if(self){
        self.modelURL = modelURL;
        self.storeURL = storeURL;
        [self setupObjectContext];
    }
    return self;
}
#pragma mark - public methods
- (NSManagedObjectContext *) createPrivateContext {
    NSManagedObjectContext* context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = self.managedObjectContext.persistentStoreCoordinator;
    return context;
}
#pragma mark - private methods
- (void)setupObjectContext {
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError* error;
    [self.managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                       configuration:nil
                                                                                 URL:self.storeURL
                                                                             options:nil
                                                                               error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    [self setupNotifications];
}
- (void) setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mergeManagedObjectContext:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:nil];
}
- (void) mergeManagedObjectContext: (NSNotification *) notification {
    if (notification.object != self.managedObjectContext) {
        [self.managedObjectContext performBlock:^(){
            [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
        }];
    }
}
- (NSManagedObjectModel *)managedObjectModel {
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
}

@end