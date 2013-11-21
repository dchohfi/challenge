//
// Created by Diego Chohfi on 11/21/13.
// Copyright (c) 2013 Diego Chohfi. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface DCPersistenceHelper : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

- (id)initWithStoreURL:(NSURL *)storeURL modelURL:(NSURL *)modelURL;
- (NSManagedObjectContext *) createPrivateContext;

@end