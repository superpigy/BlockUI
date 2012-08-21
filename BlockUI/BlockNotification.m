//
//  BlockNotification.m
//  BlockUI
//
//  Created by Cai8 on 12-8-21.
//  Copyright (c) 2012年 Cai8. All rights reserved.
//

#import "BlockNotification.h"
#import "AppDelegate.h"

static BlockNotification *sharedNotification;

@implementation BlockNotification

+(BlockNotification *)notification
{
    if(sharedNotification)
        return sharedNotification;
    sharedNotification = [[BlockNotification alloc] initWithFrame:CGRectMake(596, 40, 428, 100)];
    sharedNotification.backgroundColor = [UIColor colorWithRed:26.0f/255 green:163.0f/255 blue:232.0f/255 alpha:1];
    return sharedNotification;
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        isTouched = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(isTouched)
        return;
    isTouched = YES;
    CALayer *layer = self.layer;
    [layer addAnimation:[BlockAnimations flipAnimationWithDuration:.1f forLayerBeginingOnTop:YES] forKey:nil];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!isTouched)
        return;
    CALayer *layer = self.layer;
    [layer addAnimation:[BlockAnimations flipAnimationWithDuration:.1f forLayerBeginingOnTop:NO] forKey:nil];
}

- (void)showWithTitle:(NSString *)title Message:(NSString *)message target:(id)target selector:(SEL)selector
{
    UILabel *titleLabel = (UILabel *)[self viewWithTag:1000];
    if(!titleLabel)
    {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 388, 22)];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setNumberOfLines:1];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [titleLabel setTag:1000];
        [titleLabel setTextAlignment:UITextAlignmentLeft];
        [self addSubview:titleLabel];
    }
    [titleLabel setText:title];

    UILabel *messageLabel = (UILabel *)[self viewWithTag:1001];
    CGSize maximumLabelSize = CGSizeMake(388, 44);
    CGSize expectedLabelSize = [message sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeWordWrap];
    if(!messageLabel)
    {
        messageLabel = [[UILabel alloc] init];
        [messageLabel setTextColor:[UIColor whiteColor]];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        [messageLabel setNumberOfLines:5];
        [messageLabel setFont:[UIFont systemFontOfSize:16]];
        [messageLabel setTag:1001];
        [messageLabel setTextAlignment:UITextAlignmentLeft];
        [self addSubview:messageLabel];
    }
    [messageLabel setText:message];
    [messageLabel setFrame:CGRectMake(20, 12 + titleLabel.bounds.size.height, expectedLabelSize.width, expectedLabelSize.height)];

    self.alpha = 0;
    self.transform = CGAffineTransformTranslate(self.transform, 200,0);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window.rootViewController.view addSubview:self];

    [UIView animateWithDuration:.2f delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:nil];
    [self performSelector:@selector(hide) withObject:nil afterDelay:15];
}

-(void)hide
{
    [UIView animateWithDuration:.2f delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeTranslation(200, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
