//
//  BlockItem.h
//  BlockUI
//
//  Created by Cai8 on 12-8-9.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockButton.h"

typedef enum
{
    Text,
    Image,
    Media
}BlockItemType;

@class BlockItem;
@protocol BlockItemDelegate <NSObject>

- (void)loadAsyncCallback;

@end

@interface BlockItem : NSObject
{
    NSString *imageUrl;
}

@property (nonatomic,strong) NSString *itemTitle;
@property (nonatomic,strong) id itemView;
@property (nonatomic,assign) MatrixRect m_frame;
@property (nonatomic,assign) BlockItemType type;
@property (nonatomic,assign) NSInteger groupIndex;
@property (nonatomic,assign) BOOL autosizing;
@property (nonatomic,assign) id<BlockItemDelegate> delegate;

+ (id)blockItemWithType:(BlockItemType)bType Title:(NSString *)title thumbnailUrl:(NSString *)url itemCoordinate:(ButtonCoordinate)coordinate onTouch:(ButtonActionBlock)actionBlock;

- (id)initWithItemType:(BlockItemType)bType Title:(NSString *)title thumbnailUrl:(NSString *)url target:(id)target action:(SEL)selector;

- (void)loadAsync;

@end
