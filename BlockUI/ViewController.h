//
//  ViewController.h
//  BlockUI
//
//  Created by Cai8 on 12-8-9.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockContainer.h"

@class CommandProcessor;
@interface ViewController : UIViewController<UIScrollViewDelegate,BlockContainerDataSource>
{
    UIView *overylay;
    CommandProcessor *processor;
}

@property (nonatomic,strong) BlockContainer *container;
@property (nonatomic,strong) NSOperationQueue *queue;

@end
