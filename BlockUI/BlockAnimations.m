//
//  BlockAnimations.m
//  BlockUI
//
//  Created by Cai8 on 12-8-21.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import "BlockAnimations.h"

@implementation BlockAnimations

+ (CAAnimation *)flipAnimationWithDuration:(NSTimeInterval)duration forLayerBeginingOnTop:(BOOL)beginOnTop
{
    CABasicAnimation *touchAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    CGFloat startValue = beginOnTop ? 0.0f : DEGREES_TO_RADIANS(30);
    CGFloat endValue = beginOnTop ? -DEGREES_TO_RADIANS(30) : 0.0f;
    touchAnimation.fromValue = [NSNumber numberWithDouble:startValue];
    touchAnimation.toValue = [NSNumber numberWithDouble:endValue];
    touchAnimation.duration = duration;
    touchAnimation.removedOnCompletion = NO;
    return touchAnimation;
}

@end
