//
//  UIImage+HAAdditions.m
//  HAToolkit
//
//  Created by Hasan Adil on 6/9/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import <Accelerate/Accelerate.h>
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

#pragma mark Visual Effects

- (void)imageByApplyingBlurWithRadius:(CGFloat)blurRadius andCompletion:(void(^)(UIImage* image, NSError* eror))completion {
    if ((blurRadius < 0.0f) || (blurRadius > 1.0f)) {
        blurRadius = 0.5f;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        int boxSize = (int)(blurRadius * 100);
        boxSize -= (boxSize % 2) + 1;
        CGImageRef rawImage = self.CGImage;
        vImage_Buffer inBuffer, outBuffer;
        vImage_Error error;
        void *pixelBuffer;
        
        CGDataProviderRef inProvider = CGImageGetDataProvider(rawImage);
        CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
        inBuffer.width = CGImageGetWidth(rawImage);
        inBuffer.height = CGImageGetHeight(rawImage);
        inBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
        inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
        
        pixelBuffer = malloc(CGImageGetBytesPerRow(rawImage) * CGImageGetHeight(rawImage));
        outBuffer.data = pixelBuffer;
        outBuffer.width = CGImageGetWidth(rawImage);
        outBuffer.height = CGImageGetHeight(rawImage);
        outBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        if (error) {
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, [NSError errorWithDomain:@""
                                                        code:error
                                                    userInfo:@{
                                                               NSLocalizedDescriptionKey:NSLocalizedString(@"Unable to apply a blur to image.", nil)
                                                               }]);
                });
            }
        }
        else {
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGContextRef ctx = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, CGImageGetBitmapInfo(self.CGImage));
            CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
            UIImage *blurredImage = [UIImage imageWithCGImage:imageRef];
            
            //clean up
            CGContextRelease(ctx); CGColorSpaceRelease(colorSpace); free(pixelBuffer); CFRelease(inBitmapData); CGImageRelease(imageRef);
            
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(blurredImage, nil);
                });
            }
        }
    });
}

@end
