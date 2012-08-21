//
//  BlockUI.c
//  BlockUI
//
//  Created by Cai8 on 12-8-12.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#include <stdio.h>
#include "BlockUI.h"

MatrixPoint MatrixPointMake(int x,int y)
{
    MatrixPoint point;
    point.unit_x = x;
    point.unit_y = y;
    return point;
}

MatrixSize MatrixSizeMake(int width,int height)
{
    MatrixSize size;
    size.hUnits = width;
    size.vUnits = height;
    return size;
}

MatrixRect MatrixRectMake(int x,int y,int width,int height)
{
    MatrixRect rect;
    rect.origin = MatrixPointMake(x, y);
    rect.size = MatrixSizeMake(width, height);
    return rect;
}

ButtonCoordinate ButtonCoordinateMake(int ix_box,int ix_item)
{
    ButtonCoordinate coordinate;
    coordinate.BoxIndex = ix_box;
    coordinate.ItemIndex = ix_item;
    return coordinate;
}

int IsInvalidPoint(MatrixPoint point)
{
    int isInvalid = -1;
    if(point.unit_x != -1 && point.unit_y != -1)
        isInvalid = 0;
    return isInvalid;
}