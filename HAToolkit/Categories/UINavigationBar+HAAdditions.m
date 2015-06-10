//
//  UINavigationBar+HAAdditions.m
//  HAToolkit
//
//  Created by Hasan Adil on 6/9/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import "UINavigationBar+HAAdditions.h"

@implementation UINavigationBar (HAAdditions)

-(void) clearBackground {
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = [UIImage new];
    self.translucent = YES;
}

@end
