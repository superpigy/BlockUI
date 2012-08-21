//
//  BlockGroup.m
//  BlockUI
//
//  Created by Cai8 on 12-8-9.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import "BlockGroup.h"

@implementation BlockGroup

+ (BlockGroup *)group
{
    BlockGroup *group = [[BlockGroup alloc] init];
    [group assignMatrix:[[Matrix alloc] initWithRow:DEFAULT_VERTICAL_UNITS Column:DEFAULT_HORIZONTAL_UNITS]];
    return group;
}

+ (BlockGroup *)groupWithMatrix:(Matrix *)matrix
{
    BlockGroup *group = [[BlockGroup alloc] init];
    [group assignMatrix:matrix];
    return group;
}

+ (CGSize)CGSizeForGroup:(BlockGroup *)group
{
    return CGSizeMake([group width], [group height]);
}

- (void)layoutItem:(BlockItem *)item
{
    if(!layoutMatrix)
        return;
    [layoutMatrix setItemOccupation:item];
    
}

- (void)assignMatrix:(Matrix *)matrix
{
    layoutMatrix = matrix;
}

- (BOOL)isFull
{
    return [layoutMatrix isFull];
}

- (CGFloat)height
{
    return [Matrix MatrixSizeToCGSize:MatrixSizeMake(layoutMatrix.size.hUnits, layoutMatrix.size.vUnits)].height;
}

- (CGFloat)width
{
    return [Matrix MatrixSizeToCGSize:MatrixSizeMake(layoutMatrix.size.hUnits,layoutMatrix.size.vUnits)].width;
}

@end
