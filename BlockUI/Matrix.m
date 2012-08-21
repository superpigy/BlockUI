//
//  Matrix.m
//  BlockUI
//
//  Created by Cai8 on 12-8-9.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import "Matrix.h"

@interface Matrix()
- (BOOL)isOccupiedOnPositionForRow:(NSInteger)row_pos Column:(NSInteger)col_pos;
- (void)changePositionStatus:(MatrixPoint)position Tag:(NSInteger)tag;
@end

@implementation Matrix

+ (Matrix *)matrixWithRow:(NSInteger)row Column:(NSInteger)column
{
    Matrix *matrix = [[Matrix alloc] initWithRow:row Column:column];
    return matrix;
}

+ (CGSize)MatrixSizeToCGSize:(MatrixSize)size
{
    return CGSizeMake(LENGTH_OF_UNITS(size.hUnits, DEFAULT_WIDTH_OF_UNIT, DEFAULT_MARGIN_OF_UNIT),
                             LENGTH_OF_UNITS(size.vUnits, DEFAULT_HEIGHT_OF_UNIT, DEFAULT_MARGIN_OF_UNIT));
}

+ (CGPoint)MatrixPointToCGPoint:(MatrixPoint)point StartPoint:(CGPoint)p UnitLength:(CGFloat)ul MarginLength:(CGFloat)ml
{
    CGFloat x_asix = point.unit_x * (ul + ml) + p.x;
    CGFloat y_asix = point.unit_y * (ul + ml) + p.y;
    return CGPointMake(x_asix, y_asix);
}

- (id)initWithRow:(NSInteger)row Column:(NSInteger)column
{
    if(self =[super init])
    {
        @autoreleasepool {
            for(int i=0;i<row;i++)
            {
                NSMutableArray *array = [NSMutableArray array];
                for(int j=0;j<column;j++)
                {
                    [array addObject:[NSNumber numberWithBool:NO]];
                }
                if(!base)
                    base = [NSMutableArray array];
                [base addObject:array];
            }
        }
        self.size = MatrixSizeMake(column, row);
    }
    return self;
}

- (void)changePositionStatus:(MatrixPoint)position Tag:(NSInteger)tag
{
    [[base objectAtIndex:position.unit_y] replaceObjectAtIndex:position.unit_x withObject:[NSNumber numberWithInteger:tag]];
}

- (BOOL)isOccupiedOnPositionForRow:(NSInteger)row_pos Column:(NSInteger)col_pos
{
    return [[[base objectAtIndex:row_pos] objectAtIndex:col_pos] intValue] != 0;
}

- (void)setItemOccupation:(BlockItem *)item
{
    MatrixPoint point = [self findAvailableStartPointForSize:item.m_frame.size];
    MatrixRect newRect = item.m_frame;
    newRect.origin = point;
    item.m_frame = newRect;
    if(IsInvalidPoint(point) == 0)
    {
        for (int i=0; i < item.m_frame.size.vUnits; i++) {
            for(int j=0;j< item.m_frame.size.hUnits;j++)
            {
                [self changePositionStatus:MatrixPointMake(j + point.unit_x, i + point.unit_y) Tag:1];
                
            }
        }
    }
    else
    {
        if(item.type != Text){
            newRect.size = MatrixSizeMake(1, 1);
            item.m_frame = newRect;
        }
        [self setItemOccupation:item];
    }
}

- (MatrixPoint)findAvailableStartPointForSize:(MatrixSize)size
{
    MatrixPoint availablePoint = MatrixPointMake(-1, -1);
    
    for(int i=0;i<self.size.vUnits;i++)
    {
        NSLog(@"%d",self.size.vUnits);
        NSLog(@"%d",size.vUnits);
        if((self.size.vUnits - i) < size.vUnits)
            break;
        
        for(int j=0;j<self.size.hUnits;j++)
        {
            if(self.size.hUnits - j < size.hUnits)
                break;
            
            if([self isOccupiedOnPositionForRow:i Column:j])
                continue;
            else
            {
                MatrixPoint checkPoint = [self validateItemBlockSize:size StartPoint:MatrixPointMake(j, i)];
                if(checkPoint.unit_x != -1 && checkPoint.unit_y != -1)
                {
                    if((self.size.hUnits - checkPoint.unit_x - 1) <= size.hUnits && self.size.hUnits - (checkPoint.unit_x + 1) > 0)
                    {
                        j = checkPoint.unit_x + 1;
                    }
                    else
                    {
                        j = 0;
                        i++;
                    }
                    continue;
                }
                else
                {
                    availablePoint = MatrixPointMake(j, i);
                    return availablePoint;
                }
            }
        }
    }
    return availablePoint;
}

- (MatrixPoint)validateItemBlockSize:(MatrixSize)size StartPoint:(MatrixPoint)point
{
    MatrixPoint invalidPoint = MatrixPointMake(-1, -1);
    for(int chkRow = point.unit_y;chkRow < size.vUnits;chkRow++)
        for(int chkCol = point.unit_x;chkCol < size.hUnits;chkCol++)
        {
            if([self isOccupiedOnPositionForRow:chkRow Column:chkCol])
            {
                invalidPoint = MatrixPointMake(chkCol, chkRow);
            }
        }
    return invalidPoint;
}

- (BOOL)isFull
{
    for(int i=0;i<self.size.vUnits;i++)
        for(int j=0;j<self.size.hUnits;j++)
            if(![self isOccupiedOnPositionForRow:i Column:j])
                return NO;
    return YES;
}
@end
