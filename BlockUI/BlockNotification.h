//
//  BlockNotification.h
//  BlockUI
//
//  Created by Cai8 on 12-8-21.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockAnimations.h"

@interface BlockNotification : UIView
{
    BOOL isTouched;
}

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *message;

+ (BlockNotification *)notification;

- (void)showWithTitle:(NSString *)title Message:(NSString *)message target:(id)target selector:(SEL)selector;

- (void)hide;
@end
