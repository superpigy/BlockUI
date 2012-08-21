//
//  BlockItem.m
//  BlockUI
//
//  Created by Cai8 on 12-8-9.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import "BlockItem.h"

@implementation BlockItem

+ (id)blockItemWithType:(BlockItemType)bType Title:(NSString *)title thumbnailUrl:(NSString *)url itemCoordinate:(ButtonCoordinate)coordinate onTouch:(ButtonActionBlock)actionBlock
{
    BlockItem *item = [[BlockItem alloc] init];
    [item setItemTitle:title];
    [item setType:bType];
    item.itemView = [BlockButton buttonWithType:UIButtonTypeCustom];
    [item.itemView onTouch:actionBlock];
    return item;
}

- (id)initWithItemType:(BlockItemType)bType Title:(NSString *)title thumbnailUrl:(NSString *)url target:(id)target action:(SEL)selector
{
    if(self = [super init])
    {
        imageUrl = url;
        self.type = bType;
        self.itemTitle = title;
        self.itemView = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.itemView addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)loadAsync
{
    //Item Rect has been initialized..
    switch (self.type) {
        case Text:
        {
            [self.itemView setTitle:self.itemTitle forState:UIControlStateNormal];
            [[self.itemView titleLabel] setFont:[UIFont fontWithName:DEFAULT_FONT_NAME size:30]];
            [[self.itemView titleLabel] setTextColor:[UIColor whiteColor]];
            [self.itemView setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [self.itemView setBackgroundColor:[UIColor clearColor]];
            [self.itemView setReversesTitleShadowWhenHighlighted:YES];
            [self.itemView setShowsTouchWhenHighlighted:YES];
        }
            break;
        case Image:
        {
            [self.itemView setAlpha:0];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self.itemView setImage:image forState:UIControlStateNormal];
                        [UIView animateWithDuration:.2f delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                            [self.itemView setAlpha:1];
                        } completion:nil];
                    });
            });
        }
            break;
        case Media:
        {
            [self.itemView setAlpha:0];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.itemView setImage:image forState:UIControlStateNormal];
                    [UIView animateWithDuration:.2f delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                        [self.itemView setAlpha:1];
                    } completion:nil];
                });
            });
        }
            break;
        default:
            break;
    }
}

@end
