//
// Created by Diego Chohfi on 11/21/13.
// Copyright (c) 2013 Diego Chohfi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "DCPersistenceHelper.h"

@interface UIResponder (DCAdditions)

+ (DCPersistenceHelper *) persistentStoreHelper;

@end