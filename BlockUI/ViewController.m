//
//  ViewController.m
//  BlockUI
//
//  Created by Cai8 on 12-8-9.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import "ViewController.h"
#import "BlockContainer.h"
#import "BlockNotification.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    overylay = [[UIView alloc] initWithFrame:self.view.bounds];
    [overylay setBackgroundColor:[UIColor colorWithWhite:0 alpha:.85f]];
    if(!self.container)
        self.container = [[BlockContainer alloc] initWithFrame:CGRectMake(0, 74, overylay.bounds.size.width, 600)];
    [self.container setDelegate:self];
    [self.container setDataSource:self];
    self.container.opaque = NO;
    [self.container setAlwaysBounceHorizontal:YES];
    [overylay addSubview:self.container];

    [self.view addSubview:overylay];
    [self.container rebuild];
}

#pragma - Block UI Delegate
- (NSInteger)numberOfBoxes
{
    return 4;
}

- (BlockBox *)blockBoxForContainer:(BlockContainer *)container atIndex:(NSInteger)index
{
    BlockBox *box = [container dequeue];
    if(!box)
    {
        box = [[BlockBox alloc] init];
    }
    [self configureBox:box AtIndex:index];
    return box;
}

- (CGFloat)marginBetweenBoxes
{
    return 30;
}

- (CGSize)sizeForBoxForContainer:(BlockContainer *)container atIndex:(NSInteger)index
{
    return [[container boxAtIndex:index] size];
}

- (NSOperationQueue *)queue
{
    if(self.queue)
        return self.queue;
    self.queue = [[NSOperationQueue alloc] init];
    self.queue.maxConcurrentOperationCount = 2;
    return self.queue;
}

#pragma - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"Dragging...");
}

#pragma - Box Configuration

- (void)configureBox:(BlockBox *)box AtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [box configureBoxWithTitle:@"menu"];
            BlockItem *menuItem1 = [[BlockItem alloc] initWithItemType:Text Title:@"onlive radio station" thumbnailUrl:nil target:self action:@selector(test:)];
            BlockItem *menuItem2 = [[BlockItem alloc] initWithItemType:Text Title:@"people" thumbnailUrl:nil target:nil action:nil];
            BlockItem *menuItem3 = [[BlockItem alloc] initWithItemType:Text Title:@"tracking station" thumbnailUrl:nil target:nil action:nil];
            [box addBlockItem:menuItem1];
            [box addBlockItem:menuItem2];
            [box addBlockItem:menuItem3];
        }
            break;
        case 1:
        {
            [box configureBoxWithTitle:@"spotlight"];
            BlockItem *item1 = [[BlockItem alloc] initWithItemType:Image Title:@"nature1" thumbnailUrl:@"http://www.hdwallpapersarena.com/wp-content/uploads/2012/07/3d-nature-wallpaper-waterfall-wallpaper.jpg" target:nil action:nil];
            BlockItem *item2 = [[BlockItem alloc] initWithItemType:Image Title:@"nature2" thumbnailUrl:@"http://www.hdwallpapersarena.com/wp-content/uploads/2012/07/3d-nature-wallpaper-waterfall-wallpaper.jpg" target:nil action:nil];
            [box addBlockItem:item1];
            [box addBlockItem:item2];
        }
            break;
        case 2:
        {
            [box configureBoxWithTitle:@"features"];
            
        }
            break;
        case 3:
            break;
        default:
            break;
    }
}

- (void)test:(id)sender
{
    BlockNotification *notification = [BlockNotification notification];
    [notification showWithTitle:@"test" Message:@"test message" target:nil selector:nil inView:self.view];
}

#pragma - View loading delegate

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

@end
