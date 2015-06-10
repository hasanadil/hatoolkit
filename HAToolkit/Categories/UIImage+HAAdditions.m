//
//  UIImage+HAAdditions.m
//  HAToolkit
//
//  Created by Hasan Adil on 6/9/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import "UIImage+HAAdditions.h"

@implementation UIImage (HAAdditions)

+(CGSize) barButtonImageSize
{
    return CGSizeMake(26.f, 26.f);
}

-(UIImage*) resizeImage:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    
    [self drawInRect:CGRectMake(0, 0, newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:1];
    
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

#pragma mark - Public methods

- (UIImage *)tintedGradientImageWithColor:(UIColor *)tintColor
{
    return [self tintedImageWithColor:tintColor blendingMode:kCGBlendModeOverlay];
}

- (UIImage *)tintedImageWithColor:(UIColor *)tintColor
{
    return [self tintedImageWithColor:tintColor blendingMode:kCGBlendModeDestinationIn];
}

- (UIImage*) tintedImageWithWindowTint
{
    UIColor* tintColor = [[[UIApplication sharedApplication] windows][0] tintColor];
    return [self tintedImageWithColor:tintColor];
}

#pragma mark - Private methods

- (UIImage *)tintedImageWithColor:(UIColor *)tintColor blendingMode:(CGBlendMode)blendMode
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn)
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

#pragma mark strings

- (NSString *)encodeToBase64String {
    return [UIImagePNGRepresentation(self) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}


@end
