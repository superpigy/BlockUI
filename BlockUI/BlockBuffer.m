//
//  BlockBuffer.m
//  BlockUI
//
//  Created by Cai8 on 12-8-15.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import "BlockBuffer.h"

@implementation BlockBuffer

+ (id)buffer
{
    BlockBuffer *bf = [[BlockBuffer alloc] init];
    NSMutableDictionary *cache = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSMutableArray array],ITEM_IN_USE,
                                  [NSMutableArray array],ITEM_WILL_REUSE, nil];
    [bf setCache:cache];
    return bf;
}

- (void)setCache:(id)buffer
{
    cache = buffer;
}

- (id)dequeueFreeItem
{
    id item = nil;
    @try {
        item = [[[cache objectForKey:ITEM_WILL_REUSE] objectAtIndex:0] copy];
        [[cache objectForKey:ITEM_WILL_REUSE] removeObject:item];
    }
    @catch (NSException *exception) {
        item = nil;
    }
    @finally {
        return item;
    }
}

- (void)freeItem:(id)item
{
    [[cache objectForKey:ITEM_WILL_REUSE] addObject:item];
}

- (void)enqueueItem:(id)item
{
    [[cache objectForKey:ITEM_IN_USE] addObject:item];
}

- (id)boxesInUse
{
    return [cache objectForKey:ITEM_IN_USE];
}

@end
