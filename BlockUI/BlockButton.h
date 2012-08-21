//
//  BlockButton.h
//  BlockUI
//
//  Created by Cai8 on 12-8-14.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlockButton;
typedef void (^ButtonActionBlock)(BlockButton *sender);

@interface BlockButton : UIButton
{
    ButtonActionBlock _actionBlock;
}
@property (nonatomic,assign) ButtonCoordinate coordinate;

- (void)onTouch:(ButtonActionBlock)action;
@end
