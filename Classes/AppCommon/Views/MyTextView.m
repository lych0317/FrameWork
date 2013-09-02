//
//  MyTextView.m
//  DashBoard
//
//  Created by 远超 李 on 13-7-31.
//  Copyright (c) 2013年 zero. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

@synthesize placeholderLabel = _placeholderLabel;

- (void)setPlaceholderLabel:(UILabel *)placeholderLabel
{
    if (_placeholderLabel != placeholderLabel)
    {
        _placeholderLabel = placeholderLabel;
        _placeholderLabel.frame = CGRectMake(10, 5, self.frame.size.width - 20, self.frame.size.height - 10);
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = [UIColor colorWithRed:49.0/255 green:53.0/255 blue:60.0/255 alpha:.5];
        _placeholderLabel.font = [UIFont systemFontOfSize:14];
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
        _placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.text = placeholderLabel.text;
        [self addSubview:_placeholderLabel];
    }
}

@end
