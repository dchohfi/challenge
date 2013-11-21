//
// Created by Diego Chohfi on 11/21/13.
// Copyright (c) 2013 Diego Chohfi. All rights reserved.
//


#import "UIViewController+DCAdditions.h"


@implementation UIViewController (DCAdditions)
- (UINavigationController *) withNagivation {
    return [[UINavigationController alloc] initWithRootViewController:self];
}
@end