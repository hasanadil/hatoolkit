//
//  UIView+HAAdditions.m
//  HAToolkit
//
//  Created by Hasan Adil on 6/9/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import "UIView+HAAdditions.h"

@implementation UIView (HAAdditions)

-(NSArray*) allGestures
{
    NSArray* gestures = [self gestureRecognizers];
    for (UIView* subview in [self subviews]) {
        gestures = [gestures arrayByAddingObjectsFromArray:[subview allGestures]];
    }
    return gestures;
}

-(UIImage*) imageFromView
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void) pulseWithRepeatCount:(NSInteger)repeatCount andCompletion:(void (^)())completion
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        if (completion) {
            completion();
        }
    }];
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 3;
    opacityAnimation.values = @[@0.45, @1, @0];
    opacityAnimation.keyTimes = @[@0, @0.2, @1];
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    [self.layer addAnimation:opacityAnimation forKey:@"opacity"];
    [CATransaction commit];
}

+ (CAKeyframeAnimation*)dockBounceAnimationWithViewHeight:(CGFloat)viewHeight
{
    NSUInteger const kNumFactors    = 22;
    CGFloat const kFactorsPerSec    = 30.0f;
    CGFloat const kFactorsMaxValue  = 128.0f;
    CGFloat factors[kNumFactors]    = {0,  60, 83, 100, 114, 124, 128, 128, 124, 114, 100, 83, 60, 32, 0, 0, 18, 28, 32, 28, 18, 0};
    
    NSMutableArray* transforms = [NSMutableArray array];
    
    for(NSUInteger i = 0; i < kNumFactors; i++)
    {
        CGFloat positionOffset  = factors[i] / kFactorsMaxValue * viewHeight;
        CATransform3D transform = CATransform3DMakeTranslation(0.0f, -positionOffset, 0.0f);
        
        [transforms addObject:[NSValue valueWithCATransform3D:transform]];
    }
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.repeatCount           = 1;
    animation.duration              = kNumFactors * 1.0f/kFactorsPerSec;
    animation.fillMode              = kCAFillModeForwards;
    animation.values                = transforms;
    animation.removedOnCompletion   = YES; // final stage is equal to starting stage
    animation.autoreverses          = NO;
    
    CAMediaTimingFunction* func = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [animation setTimingFunctions:@[func, func, func]];
    
    return animation;
}

- (void)bounce:(float)bounceFactor
{
    CGFloat midHeight = self.frame.size.height * bounceFactor;
    CAKeyframeAnimation* animation = [[self class] dockBounceAnimationWithViewHeight:midHeight];
    [self.layer addAnimation:animation forKey:@"bouncing"];
}

-(void) setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(void) fadeOut
{
    __weak typeof(self) me = self;
    [UIView animateWithDuration:0.3 animations:^{
        me.alpha = 0;
    }];
}

-(void) fadeIn
{
    __weak typeof(self) me = self;
    [UIView animateWithDuration:0.3 animations:^{
        me.alpha = 1;
    }];
}

-(void) showTouchAt:(CGPoint)point usingColor:(UIColor*)color andCompletion:(void(^)())completion {
    CAShapeLayer *circle;
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        if (circle) {
            [circle removeFromSuperlayer];
        }
        if (completion) {
            completion();
        }
    }];
    
    CGFloat radius = 5;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:point
                    radius:radius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    
    circle = [CAShapeLayer layer];
    circle.path = [path CGPath];
    circle.strokeColor = [[UIColor clearColor] CGColor];
    circle.fillColor = [color CGColor];
    circle.lineWidth = 3.0;
    [self.layer addSublayer:circle];
    
    //animate it
    CGFloat newRadius = 60;
    UIBezierPath *newPath = [UIBezierPath bezierPath];
    [newPath addArcWithCenter:point
                       radius:newRadius
                   startAngle:0.0
                     endAngle:M_PI * 2.0
                    clockwise:YES];
    
    CABasicAnimation* pathAnim = [CABasicAnimation animationWithKeyPath: @"path"];
    pathAnim.toValue = (id)newPath.CGPath;
    
    CABasicAnimation* opacityAnim = [CABasicAnimation animationWithKeyPath: @"opacity"];
    opacityAnim.toValue = @(0);
    
    CAAnimationGroup *anims = [CAAnimationGroup animation];
    anims.animations = [NSArray arrayWithObjects:pathAnim, opacityAnim, nil];
    anims.removedOnCompletion = NO;
    anims.duration = .75f;
    anims.fillMode  = kCAFillModeForwards;
    [circle addAnimation:anims forKey:nil];
    
    [CATransaction commit];
}

@end
