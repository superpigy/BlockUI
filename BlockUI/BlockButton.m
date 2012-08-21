//
//  BlockButton.m
//  BlockUI
//
//  Created by Cai8 on 12-8-14.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import "BlockButton.h"

@implementation BlockButton

- (id)init
{
    if(self =[super init])
    {

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)onTouch:(ButtonActionBlock)action
{
    _actionBlock = [action copy];
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)callActionBlock:(BlockButton *)sender
{
    _actionBlock(sender);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
