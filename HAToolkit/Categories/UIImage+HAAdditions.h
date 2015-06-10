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

#pragma mark Utils

- (UIImage*)resizeImage:(CGSize)newSize;

#pragma mark Colors

- (UIImage*)tintedGradientImageWithColor:(UIColor *)tintColor;
- (UIImage*)tintedImageWithColor:(UIColor *)tintColor;
- (UIImage*)tintedImageWithWindowTint;

#pragma mark Encoding

- (NSString *)encodeToBase64String;
- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

#pragma mark Visual Effects

- (void)imageByApplyingBlurWithRadius:(CGFloat)blurRadius andCompletion:(void(^)(UIImage* image, NSError* eror))completion;

@end
