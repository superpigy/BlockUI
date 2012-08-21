//
//  BlockBox.h
//  BlockUI
//
//  Created by Cai8 on 12-8-9.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockItem.h"
#import "BlockGroup.h"

@interface BlockBox : NSObject
{
    NSMutableArray *items;
    NSMutableArray *groups;
}

@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) NSInteger index;

- (id)initBoxWithInitialPoint:(CGPoint)point Title:(NSString *)t;

- (id)itemAtIndex:(NSInteger)index;

- (void)addBlockItem:(BlockItem *)item;

- (void)collection:(NSArray *)itemCollection;

- (void)prepareItemGrouping;

- (void)clean;

- (void)configureBoxWithTitle:(NSString *)title;

- (CGSize)size;

- (void)drawOnView:(UIView *)view;

@end
