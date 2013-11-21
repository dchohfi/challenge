//
//  DCAppDelegate.h
//  blinkbox-challenge
//
//  Created by Diego Chohfi on 11/21/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCPersistenceHelper;
@interface DCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) DCPersistenceHelper *persistenceHelper;

@end
