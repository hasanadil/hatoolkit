//
//  UIImage+HAAdditions.h
//  HAToolkit
//
//  Created by Hasan Adil on 6/9/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HAAdditions)

+ (CGSize) barButtonImageSize;

- (UIImage*) resizeImage:(CGSize)newSize;

- (UIImage*)tintedGradientImageWithColor:(UIColor *)tintColor;
- (UIImage*)tintedImageWithColor:(UIColor *)tintColor;
- (UIImage*)tintedImageWithWindowTint;

- (NSString *)encodeToBase64String;
- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

@end
