//
//  DCAppDelegate.m
//  blinkbox-challenge
//
//  Created by Diego Chohfi on 11/21/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "DCAppDelegate.h"
#import "DCPersistenceHelper.h"
#import "DCPersonViewController.h"
#import "UIViewController+DCAdditions.h"
#import "DCImportPersonOperation.h"

@interface DCAppDelegate()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation DCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.persistenceHelper = [[DCPersistenceHelper alloc] initWithStoreURL:self.storeURL
                                                                  modelURL:self.modelURL];
    self.window.rootViewController = [[[DCPersonViewController alloc] init] withNagivation];
    [self importInitialData];
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark - private methods
- (void) importInitialData {
    self.operationQueue = [[NSOperationQueue alloc] init];
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Persons" ofType:@"plist"];
    DCImportPersonOperation *personOperation = [[DCImportPersonOperation alloc] initWithFile:filePath];
    [self.operationQueue addOperation:personOperation];
}
- (NSURL*)storeURL {
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                       inDomain:NSUserDomainMask
                                                              appropriateForURL:nil
                                                                         create:YES
                                                                          error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"blinkbox_challenge.sqlite"];
}

- (NSURL*)modelURL {
    return [[NSBundle mainBundle] URLForResource:@"blinkbox_challenge" withExtension:@"momd"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.persistenceHelper.managedObjectContext save:NULL];
}

@end
