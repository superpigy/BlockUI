//
//  BlockContainer.m
//  BlockUI
//
//  Created by Cai8 on 12-8-14.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import "BlockContainer.h"

@interface BlockContainer()
- (void)prepareBoxAtIndex:(NSInteger)index;
@end

@implementation BlockContainer

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        lastBoxIndex = 0;
        buffer = [BlockBuffer buffer];
    }
    return self;
}

-(NSArray *)visibleBlocks
{
    return [buffer boxesInUse];
}


- (BlockBox *)boxAtIndex:(NSInteger)index
{
    return [self.dataSource blockBoxForContainer:self atIndex:index];
}

- (BlockBox *)dequeue
{
    return [buffer dequeueFreeItem];
}

- (void)rebuild
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self setContentOffset:CGPointMake(0, 0) animated:NO];
        buildingOffset = CGPointMake(GROUP_LEFT_BOUNDARY_MARGIN, GROUP_TOP_BOUNDARY_MARGIN);
        for(int i=0;i<[self.dataSource numberOfBoxes];i++)
        {
            if(buildingOffset.x > self.contentOffset.x + self.bounds.size.width)
                break;
            @autoreleasepool {
                [self prepareBoxAtIndex:i];
            }
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            for(BlockBox *box in [buffer boxesInUse])
            {
                [box drawOnView:self];
            }
        });
    });
}

- (void)prepareBoxAtIndex:(NSInteger)index
{
    BlockBox *box = [self.dataSource blockBoxForContainer:self atIndex:index];
    [box setOrigin:buildingOffset];
    [box prepareItemGrouping];
    if(box.origin.x >= self.contentOffset.x && box.origin.x <= self.contentOffset.x + self.bounds.size.width)
    {
        [self addRect:CGRectMake(buildingOffset.x, buildingOffset.y, [box size].width, [box size].height)];
        [buffer enqueueItem:box];
        buildingOffset.x += [box size].width + [self.dataSource marginBetweenBoxes];
    }
}

- (void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
    
}

-(void)addRect:(CGRect)rect
{
    CGSize contentSize = self.contentSize;
    if(rect.origin.x >= self.contentOffset.x && rect.origin.x <= self.contentOffset.x + self.contentSize.width)
    {
        if(rect.size.width + rect.origin.x > self.contentOffset.x + self.contentSize.width)
        {
            contentSize.width += rect.origin.x + rect.size.width - (self.contentOffset.x + contentSize.width) + [self.dataSource marginBetweenBoxes];
        }
    }
    else if(rect.origin.x >= self.contentOffset.x && rect.origin.x > self.contentOffset.x + self.contentSize.width)
    {
        contentSize.width += (rect.origin.x - (self.contentOffset.x + self.contentSize.width)) + rect.size.width + [self.dataSource marginBetweenBoxes];
    }
    self.contentSize = contentSize;

    NSLog(@"Newly Scrollable Size : %f",self.contentSize.width);
}

@end
