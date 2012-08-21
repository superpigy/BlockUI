//
//  BlockGroup.h
//  BlockUI
//
//  Created by Cai8 on 12-8-9.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockItem.h"
#import "Matrix.h"

@interface BlockGroup : NSObject
{
    Matrix *layoutMatrix;
}

@property (nonatomic,assign) CGPoint origin;

- (CGFloat)height;

- (CGFloat)width;

- (BOOL)isFull;

- (void)assignMatrix:(Matrix *)matrix;

- (void)layoutItem:(BlockItem *)item;

+ (BlockGroup *)group;

+ (BlockGroup *)groupWithMatrix:(Matrix *)matrix;

+ (CGSize)CGSizeForGroup:(BlockGroup *)group;

@end
