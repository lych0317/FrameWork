//
//  TransformAnimationHelper.h
//  DashBoard
//
//  Created by 远超 李 on 13-7-17.
//  Copyright (c) 2013年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransformAnimationHelper : NSObject

+ (void)transformAnimationWithViews:(NSArray *)views andWithPoints:(NSArray *)points completion:(void (^)(BOOL finished))completion;

@end
