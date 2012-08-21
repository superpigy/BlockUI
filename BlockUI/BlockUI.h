//
//  BlockUI.h
//  BlockUI
//
//  Created by Cai8 on 12-8-12.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#define DEFAULT_HORIZONTAL_UNITS 4
#define DEFAULT_VERTICAL_UNITS 4
#define DEFAULT_WIDTH_OF_UNIT 90
#define DEFAULT_HEIGHT_OF_UNIT 90
#define DEFAULT_MARGIN_OF_UNIT 4

#define GROUP_LEFT_BOUNDARY_MARGIN 20
#define GROUP_TOP_BOUNDARY_MARGIN 20

#define MARGIN_BETWEEN_GROUPS 20

#define MAXIMUM_BLOCK_CONTAINER_BUFFER 6

#define DEFAULT_FONT_NAME @"Helvetica-Light"

#define DEFAULT_SPOTLIGHT_ITEM_SIZE MatrixSizeMake(4,3)
#define DEFAULT_FEATURES_ITEM_SIZE MatrixSizeMake(2,2)

#define LENGTH_OF_UNITS(units,units_length,margin_length) units * units_length + (units-1) * margin_length

typedef struct MatrixPoint MatrixPoint;
typedef struct MatrixSize MatrixSize;
typedef struct ButtonCoordinate ButtonCoordinate;
typedef struct MatrixRect MatrixRect;

struct MatrixSize {
    int hUnits;
    int vUnits;
};

struct MatrixPoint {
    int unit_x;
    int unit_y;
};

struct MatrixRect {
    MatrixPoint origin;
    MatrixSize size;
};

struct ButtonCoordinate {
    int BoxIndex;
    int ItemIndex;
};

MatrixRect MatrixRectMake(int x,int y,int width,int height);
MatrixPoint MatrixPointMake(int x,int y);
MatrixSize MatrixSizeMake(int width,int height);
ButtonCoordinate ButtonCoordinateMake(int ix_box,int ix_item);
int IsInvalidPoint(MatrixPoint point);
