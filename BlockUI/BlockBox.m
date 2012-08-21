//
//  BlockBox.m
//  BlockUI
//
//  Created by Cai8 on 12-8-9.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import "BlockBox.h"

@interface BlockBox()
- (void)addGroup:(BlockGroup *)group;
@end

@implementation BlockBox

- (id)initBoxWithInitialPoint:(CGPoint)point Title:(NSString *)t
{
    if(self = [super init])
    {
        self.origin = point;
        self.title = t;
    }
    return self;
}

- (id)itemAtIndex:(NSInteger)index
{
    return [items objectAtIndex:index];
}

- (void)addBlockItem:(BlockItem *)item
{
    if(!items)
        items = [NSMutableArray array];
    [items addObject:item];
}

- (void)addGroup:(BlockGroup *)group
{
    if(!groups)
        groups = [NSMutableArray array];
    [groups addObject:group];
}

- (void)prepareItemGrouping
{
    int i = 0;
    CGPoint groupOffset = self.origin;
    groupOffset.y += 66; //Spacing for block title
    BlockGroup *group = [BlockGroup groupWithMatrix:[Matrix matrixWithRow:DEFAULT_VERTICAL_UNITS Column:DEFAULT_HORIZONTAL_UNITS]];
    [group setOrigin:groupOffset];
    for(BlockItem *item in items)
    {
        @autoreleasepool
        {
            if([group isFull])
            {
                [self addGroup:group];
                groupOffset.x += [group width] + MARGIN_BETWEEN_GROUPS;
                group = [BlockGroup groupWithMatrix:[Matrix matrixWithRow:DEFAULT_VERTICAL_UNITS Column:DEFAULT_HORIZONTAL_UNITS]];
                [group setOrigin:groupOffset];
                i++;
            }
            
            //Set Item Tag
            item.groupIndex = i;
            switch (item.type) {
                case Text:
                    item.m_frame = MatrixRectMake(0, 0, 3, 1);
                    item.autosizing = NO;
                    break;
                case Media:
                    item.m_frame = MatrixRectMake(0, 0, 2, 2);
                    item.autosizing = YES;
                    break;
                case Image:
                    item.m_frame = MatrixRectMake(0, 0, 4, 3);
                    item.autosizing = YES;
                    break;
                default:
                    break;
            }
            [group layoutItem:item];
        }
    }
    [self addGroup:group];
}

-(void)clean
{
    for(BlockItem *item in items)
    {
        [item.itemView removeFromSuperview];
    }
    
    [items removeAllObjects];
    [groups removeAllObjects];
}

- (void)drawOnView:(UIView *)view
{
    CGPoint basePoint = self.origin;
    NSLog(@"Box Size : %f",[self size].width);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(basePoint.x, basePoint.y, [self size].width, 66)];
    [label setText:self.title];
    [label setFont:[UIFont fontWithName:DEFAULT_FONT_NAME size:42]];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [view addSubview:label];
    CGPoint shift = CGPointZero;
    for(BlockItem *item in items)
    {
        NSInteger gIndex = item.groupIndex;
        shift = [[groups objectAtIndex:gIndex] origin];
        CGPoint point = [Matrix MatrixPointToCGPoint:item.m_frame.origin StartPoint:shift UnitLength:DEFAULT_WIDTH_OF_UNIT MarginLength:DEFAULT_MARGIN_OF_UNIT];
        CGSize size = [Matrix MatrixSizeToCGSize:item.m_frame.size];
        CGRect rect = CGRectMake(point.x, point.y, size.width, size.height);
        [item.itemView setFrame:rect];
        [view addSubview:item.itemView];
        [item loadAsync];
    }
}

- (void)configureBoxWithTitle:(NSString *)title
{
    self.title = title;
}

- (CGSize)size
{
    CGSize size = CGSizeZero;
    for (BlockGroup *group in groups) {
        CGSize gSize = [BlockGroup CGSizeForGroup:group];
        size.width += gSize.width + MARGIN_BETWEEN_GROUPS;
        if(gSize.height > size.height)
            size.height = gSize.height;
    }
    size.width -= MARGIN_BETWEEN_GROUPS;
    return size;
}

@end
