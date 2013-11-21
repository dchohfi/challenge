//
// Created by Diego Chohfi on 11/21/13.
// Copyright (c) 2013 Diego Chohfi. All rights reserved.
//


#import "DCImportPersonOperation.h"
#import "UIResponder+DCAdditions.h"
#import "DCPerson.h"

@interface DCImportPersonOperation()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSString *filePath;

@end

@implementation DCImportPersonOperation

- (id) initWithFile: (NSString *) filePath {
    self = [super init];
    if(self){
        self.filePath = filePath;
    }
    return self;
}

- (NSString *) keyForUserDefaults {
    return @"data_already_imported";
}

- (void)main {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:self.keyForUserDefaults]){
        return;
    }
    self.managedObjectContext = [[UIResponder persistentStoreHelper] createPrivateContext];
    self.managedObjectContext.undoManager = nil;

    [self.managedObjectContext performBlockAndWait:^{
        [self importPersonData];
    }];
}

- (void)importPersonData {
    NSArray *people = [NSArray arrayWithContentsOfFile:self.filePath];
    for (NSDictionary *person in people){
        for (int numberOfReplicas = 0; numberOfReplicas < 100; numberOfReplicas++) {
            [DCPerson insertPersonWithData:person
                    inManagedObjectContext:self.managedObjectContext];
        }
    }
    NSError *error;
    [self.managedObjectContext save:&error];
    if(!error){
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:self.keyForUserDefaults];
        [userDefaults synchronize];
    }
}

@end