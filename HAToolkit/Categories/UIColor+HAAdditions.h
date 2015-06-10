//
//  UIColor+ASUtils.h
//  Maps
//
//  Created by Hasan on 8/8/14.
//  Copyright (c) 2014 AssembleLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HAAdditions)

+ (UIColor *)colorWithHexString: (NSString *) hexString;

- (NSString*)hexString;

- (UIColor*)colorByChangingAlphaTo:(CGFloat)newAlpha;

@end
