//
//  Matrix.h
//  BlockUI
//
//  Created by Cai8 on 12-8-9.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockItem.h"

@interface Matrix : NSObject
{
    NSMutableArray *base;
}

@property (nonatomic,assign) MatrixSize size;

- (id)initWithRow:(NSInteger)row Column:(NSInteger)column;

- (void)setItemOccupation:(BlockItem *)item;

- (MatrixPoint)findAvailableStartPointForSize:(MatrixSize)size; //Size for units

- (BOOL)isFull;

+ (Matrix *)matrixWithRow:(NSInteger)row Column:(NSInteger)column;

+ (CGSize)MatrixSizeToCGSize:(MatrixSize)size;

+ (CGPoint)MatrixPointToCGPoint:(MatrixPoint)point StartPoint:(CGPoint)p UnitLength:(CGFloat)ul MarginLength:(CGFloat)ml;
@end
