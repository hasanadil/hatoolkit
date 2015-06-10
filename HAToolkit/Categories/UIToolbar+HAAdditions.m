//
//  UIToolbar+HAAdditions.m
//  HAToolkit
//
//  Created by Hasan Adil on 6/9/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import "UIToolbar+HAAdditions.h"

@implementation UIToolbar (HAAdditions)

-(void) clearBackground {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:blank forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [self setClipsToBounds:YES];
}


@end
