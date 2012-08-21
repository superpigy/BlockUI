//
//  BlockAnimations.h
//  BlockUI
//
//  Created by Cai8 on 12-8-21.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180 * M_PI)

@interface BlockAnimations : NSObject
+ (CAAnimation *)flipAnimationWithDuration:(NSTimeInterval)duration forLayerBeginingOnTop:(BOOL)beginOnTop;
@end
