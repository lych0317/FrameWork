//
//  AlertView.h
//  Communication
//
//  Created by 远超 李 on 13-8-13.
//  Copyright (c) 2013年 jonanth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MyAlertViewTypeDefault,
    MyAlertViewTypeHappy,
    MyAlertViewTypeSad
}MyAlertViewType;

@interface MyAlertView : UIView
{
    UIImageView *robotImageView;
    UIImageView *bubbleImageView;
    
    UILabel *messageLabel;
    
    UIButton *iKnowButton;
    
    UIView *containerView;
    
    UIView *bgView;
}

@property (nonatomic, copy) void (^iKnowClickBlock)(void);

- (id)initWithType:(MyAlertViewType)type andWithMessage:(NSString *)message andWithImageNameForButton:(NSString *)imageName;

- (void)showInView:(UIView *)view;

@end
