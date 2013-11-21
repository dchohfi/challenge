//
// Created by Diego Chohfi on 11/21/13.
// Copyright (c) 2013 Diego Chohfi. All rights reserved.
//


#import "UIResponder+DCAdditions.h"
#import "DCAppDelegate.h"

@implementation UIResponder (DCAdditions)

+ (DCPersistenceHelper *) persistentStoreHelper {
    return [self appDelegate].persistenceHelper;
}

#pragma mark - private methods
+ (DCAppDelegate *) appDelegate {
    return (DCAppDelegate *) [UIApplication sharedApplication].delegate;
}

@end