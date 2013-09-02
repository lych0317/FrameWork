/**
 * 为整个应用提供帮助，一些常用的代码
 * 1、播放音频
 * 2、获取当前网络状态（0 - 没有网络;1 - wifi;2 - 蜂窝网络;
 * 3、弹出alert提示信息
 * 4、获取UIImage
 */

// for play audio
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
// for check network
#import <CommonCrypto/CommonDigest.h>
#import "Reachability.h"
// for transform animation
#import "TransformAnimationHelper.h"
// for progress view
#import "MBProgressHUD.h"
#import "MyAlertView.h"
#import "RegexKitLite.h"

@interface CommonHelpers : NSObject

#pragma mark - for play audio
/**
 * play audio with name and type
 */
+ (void)playAudioWithName:(NSString *)name andWithType:(NSString *)type;

#pragma mark - for check network

typedef enum {
    NetWorkStatusNone,
    NetWorkStatusWIFI,
    NetWorkStatusWWAN
}NetWorkStatus;
/**
 * get current network status
 */
+ (NetWorkStatus)getCurrentNetworkStatus;

#pragma mark - for show alert
/**
 * show alert for display some message
 */
//+ (MyAlertView *)showAlertViewWithType:(MyAlertViewType)type andWithMessage:(NSString *)message;
//
//+ (MyAlertView *)showAlertViewWithType:(MyAlertViewType)type andWithMessage:(NSString *)message andWithInView:(UIView *)view;

+ (MyAlertView *)showAlertViewWithType:(MyAlertViewType)type andWithMessage:(NSString *)message andWithImageNameForButton:(NSString *)imageName andWithInView:(UIView *)view;

#pragma mark - for get UIImage
/**
 * get a image with name
 */
+ (UIImage *)getImageWithName:(NSString *)name;

/**
 * get a image with name and type
 */
+ (UIImage *)getImageWithName:(NSString *)name andWithType:(NSString *)type;

#pragma mark - for auto resizing flexible
/**
 * add auto resizing flexible to view
 */
+ (void)addAutoresizingFlexibleForView:(UIView *)view;

#pragma mark - for get image with view
+ (UIImage *)getImageWithView:(UIView *)view;

#pragma mark - for NSString
+ (NSString *)trimSpaceForString:(NSString *)string;

#pragma mark - for progress view
/**
 * show progress on view
 */
+ (void)showProgressWithTitle:(NSString *)title andWithAnimated:(BOOL)isAnimated;

/**
 * change progress model to change the style
 */
+ (void)changeProgressWithModel:(MBProgressHUDMode)model andWithIsSuccess:(BOOL)isSuccess;

/**
 * hide progress from view
 */
+ (void)hideProgressWithAnimated:(BOOL)isAnimated;

#pragma mark - for userdefault
/**
 * add data to userdefault
 */
+ (void)addDataToUserDefaultWithObj:(id)obj withKey:(NSString *)key;

/**
 * get data from userdefault
 */
+ (id)getDataFromUserDefaultWithKey:(NSString *)key;

/**
 * confirm email is ture
 */
+ (BOOL)isEmail:(NSString *)email;

+ (void)showAlertViewForErrorWithType:(int)type;

@end
