//
//  UIView+HAAdditions.h
//  HAToolkit
//
//  Created by Hasan Adil on 6/9/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HAAdditions)

-(NSArray*) allGestures;

-(UIImage*) imageFromView;

-(void) bounce:(float)bounceFactor;

-(void) pulseWithRepeatCount:(NSInteger)repeatCount andCompletion:(void(^)()) completion;

-(void) setOrigin:(CGPoint)origin;

-(void) fadeOut;

-(void) fadeIn;

-(void) showTouchAt:(CGPoint)point usingColor:(UIColor*)color andCompletion:(void(^)())completion;

@end
