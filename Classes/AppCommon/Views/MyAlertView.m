//
//  AlertView.m
//  Communication
//
//  Created by 远超 李 on 13-8-13.
//  Copyright (c) 2013年 jonanth. All rights reserved.
//

#import "MyAlertView.h"

@implementation MyAlertView

@synthesize iKnowClickBlock;

- (id)initWithType:(MyAlertViewType)type andWithMessage:(NSString *)message andWithImageNameForButton:(NSString *)imageName
{
    self = [super initWithFrame:CGRectMake(0, 0, WidthForScreen, HeightForScreen)];
    if (self) {
        bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthForScreen, HeightForScreen)];
        [bgView setBackgroundColor:[UIColor blackColor]];
        bgView.alpha = 0.6f;
        [self addSubview:bgView];
        
        containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 170)];
        [containerView setCenter:CGPointMake(160, isIphone5 ? 250 : 200)];
        [containerView setBackgroundColor:[UIColor colorWithRed:28.0/255.0 green:31.0/255.0 blue:37.0/255.0 alpha:1]];
        containerView.layer.cornerRadius = 10.0f;
        containerView.layer.masksToBounds = YES;
        containerView.layer.borderWidth = 1.0;
        CGColorSpaceRef ccolorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef ccolorref = CGColorCreate(ccolorSpace,(CGFloat[]){ 20.0/255.0, 23.0/255.0, 27.0/255.0, 1.0f });
        [containerView.layer setBorderColor:ccolorref];
        [self addSubview:containerView];
        
        NSString *robotImageName = type == MyAlertViewTypeDefault ? @"alert_robot_default" : type == MyAlertViewTypeHappy ? @"alert_robot_happy" : @"alert_robot_sad";
        
        robotImageView = [[UIImageView alloc] initWithImage:[CommonHelpers getImageWithName:robotImageName]];
        robotImageView.frame = CGRectMake(25, 20, 82.5, 70);
        [containerView addSubview:robotImageView];
        
        bubbleImageView = [[UIImageView alloc] initWithImage:[CommonHelpers getImageWithName:@"alert_bubble"]];
        bubbleImageView.frame = CGRectMake(110, 10, 150, 97);
        [containerView addSubview:bubbleImageView];
        
        
        iKnowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        iKnowButton.frame = CGRectMake(55, 120, 170, 40);
        imageName = imageName ? imageName : @"alertIknow";
        [iKnowButton setImage:[CommonHelpers getImageWithName:[NSString stringWithFormat:@"%@N", imageName]] forState:UIControlStateNormal];
        [iKnowButton setImage:[CommonHelpers getImageWithName:[NSString stringWithFormat:@"%@H", imageName]] forState:UIControlStateHighlighted];
        [iKnowButton addTarget:self action:@selector(iKnowClick) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:iKnowButton];
        
        messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, 110, 60)];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.numberOfLines = 0;
        messageLabel.textColor = [UIColor colorWithRed:137.0/255 green:137.0/255 blue:137.0/255 alpha:1];
        messageLabel.font = [UIFont systemFontOfSize:12];
        messageLabel.text = message;
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        [bubbleImageView addSubview:messageLabel];
        
        [CommonHelpers addAutoresizingFlexibleForView:containerView];
    }
    return self;
}

- (void)iKnowClick
{
    if (iKnowClickBlock)
    {
        iKnowClickBlock();
    }
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(1), @(1.2), @(0.0)];
    animation.keyTimes = @[@(0), @(0.4), @(0.6)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    animation.duration = 0.5;
    animation.delegate=self;
    animation.fillMode = kCAFillModeBoth;
    animation.removedOnCompletion = NO;
    [containerView.layer addAnimation:animation forKey:@"bouce"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    bgView.alpha = 0.0f;
    [self removeFromSuperview];
}

- (void)showInView:(UIView *)view
{
    if (view)
    {
        [view addSubview:self];
    }
    else
    {
        UIWindow *window = [[[UIApplication sharedApplication] windows]objectAtIndex:0];
        [window addSubview:self];
    }
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
    animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = 0.5;
    animation.fillMode = kCAFillModeBoth;
    animation.removedOnCompletion = NO;
    [containerView.layer addAnimation:animation forKey:@"bouce"];
}

@end
