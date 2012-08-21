//
//  BlockBuffer.h
//  BlockUI
//
//  Created by Cai8 on 12-8-15.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ITEM_IN_USE @"inuse"
#define ITEM_WILL_REUSE @"reuse"

@interface BlockBuffer : NSObject
{
    NSMutableDictionary *cache;
}

+ (id)buffer;

- (void)setCache:(id)buffer;

- (id)dequeueFreeItem;

- (void)freeItem:(id)item;

- (void)enqueueItem:(id)item;

- (id)boxesInUse;

@end
