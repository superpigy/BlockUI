//
//  BlockContainer.h
//  BlockUI
//
//  Created by Cai8 on 12-8-14.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockBox.h"
#import "BlockBuffer.h"

@class BlockContainer;
@protocol BlockContainerDataSource <UIScrollViewDelegate>

- (BlockBox *)blockBoxForContainer:(BlockContainer *)container atIndex:(NSInteger)index;

- (CGSize)sizeForBoxForContainer:(BlockContainer *)container atIndex:(NSInteger)index;

- (CGFloat)marginBetweenBoxes;

- (NSInteger)numberOfBoxes;

@end

@interface BlockContainer : UIScrollView
{
    BlockBuffer *buffer;
    CGPoint buildingOffset;
    NSInteger lastBoxIndex;
}

@property (nonatomic,assign) id<BlockContainerDataSource> dataSource;

- (BlockBox *)boxAtIndex:(NSInteger)index;

- (NSArray *)visibleBlocks;

- (BlockBox *)dequeue;

- (void)addRect:(CGRect)rect;

- (void)rebuild;
@end
