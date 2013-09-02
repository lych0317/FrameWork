/**
 * 为整个应用提供帮助，一些常用的代码
 * 1、播放音频
 * 2、获取当前网络状态（0 - 没有网络;1 - wifi;2 - 蜂窝网络;
 * 3、弹出alert提示信息
 */ 

#import "CommonHelpers.h"
@implementation CommonHelpers

#pragma mark -
#pragma mark for play audio
/**
 * play audio with name and type
 */
+ (void)playAudioWithName:(NSString *)name andWithType:(NSString *)type
{
    NSString *mainMenuMusicPath = [ [NSBundle mainBundle] pathForResource:name ofType:type];
    NSURL *mainMenuMusicUrl = [NSURL fileURLWithPath:mainMenuMusicPath];
    AVAudioPlayer *mainMenuMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mainMenuMusicUrl error:nil];
    mainMenuMusicPlayer.numberOfLoops = 0;
    [mainMenuMusicPlayer play];
}

#pragma mark -
#pragma mark for check network
/**
 * get current network status
 */
+ (NetWorkStatus)getCurrentNetworkStatus
{
    NetworkStatus wifiStatusTemp = [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus];
    if (wifiStatusTemp == kReachableViaWiFi) {
        return NetWorkStatusWIFI;
    }
    NetworkStatus connStatusTemp = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (connStatusTemp == kNotReachable) {
        return NetWorkStatusNone;
    }
    return NetWorkStatusWWAN;
}

#pragma mark -
#pragma mark for show alert
/**
 * show alert for display some message
 */
//+ (MyAlertView *)showAlertViewWithType:(MyAlertViewType)type andWithMessage:(NSString *)message
//{
//    MyAlertView *alert = [[MyAlertView alloc] initWithType:type andWithMessage:message];
//    [alert showInView:nil];
//    return alert;
//}
//
//+ (MyAlertView *)showAlertViewWithType:(MyAlertViewType)type andWithMessage:(NSString *)message andWithInView:(UIView *)view
//{
//    MyAlertView *alert = [[MyAlertView alloc] initWithType:type andWithMessage:message];
//    [alert showInView:view];
//    return alert;
//}

+ (MyAlertView *)showAlertViewWithType:(MyAlertViewType)type andWithMessage:(NSString *)message andWithImageNameForButton:(NSString *)imageName andWithInView:(UIView *)view
{
    MyAlertView *alert = [[MyAlertView alloc] initWithType:type andWithMessage:message andWithImageNameForButton:imageName];
    [alert showInView:view];
    return alert;
}

#pragma mark -
#pragma mark for get UIImage
/**
 * get a image with name
 */
+ (UIImage *)getImageWithName:(NSString *)name
{
    return [self getImageWithName:name andWithType:@"png"];
}

/**
 * get a image with name and type
 */
+ (UIImage *)getImageWithName:(NSString *)name andWithType:(NSString *)type
{
    NSString *imgName = isIphone5 ? [NSString stringWithFormat:@"%@-ip5", name] : name;
    NSString *path = [[NSBundle mainBundle] pathForResource:imgName ofType:type];
    if (path && path.length > 0)
    {
        return [UIImage imageWithContentsOfFile:path];
    }
    path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    return [UIImage imageWithContentsOfFile:path];
}

#pragma mark - for auto resizing flexible
/**
 * add auto resizing flexible to view
 */
+ (void)addAutoresizingFlexibleForView:(UIView *)view
{
    view.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleHeight;
    if ([view subviews] == 0) {
        return;
    }
    for (UIView *v in [view subviews]) {
        [self addAutoresizingFlexibleForView:v];
    }
}

#pragma mark - for get image with view
+ (UIImage *)getImageWithView:(UIView *)view
{
    if(UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(view.frame.size);
    }
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - for NSString
+ (NSString *)trimSpaceForString:(NSString *)string
{
    NSString *result = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    result = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return result;
}

#pragma mark - for progress view
NSTimer               *_hideProgressTimer;
MBProgressHUD         *_loading;
/**
 * show progress on view
 */
+ (void)showProgressWithTitle:(NSString *)title andWithAnimated:(BOOL)isAnimated
{
    [self hideProgressWithAnimated:NO];
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    _loading = [MBProgressHUD showHUDAddedTo:window animated:isAnimated];
    [_loading setLabelText:title];
    
    _hideProgressTimer = [NSTimer scheduledTimerWithTimeInterval:10.0f
                                                           target:self
                                                         selector:@selector(handleTimer:)
                                                         userInfo:window
                                                          repeats:NO];
}

+ (void)handleTimer:(NSTimer *)timer {
    [self hideProgressWithAnimated:YES];
}

/**
 * change progress model to change the style
 */
+ (void)changeProgressWithModel:(MBProgressHUDMode)model andWithIsSuccess:(BOOL)isSuccess
{
    NSString *imgName   = isSuccess ? @"successicon" : @"faildicon";
    NSString *labelText = isSuccess ? @"Successed"   : @"Failed";
    UIImageView *iv = [[UIImageView alloc] initWithImage:[CommonHelpers getImageWithName:imgName]];
    [iv setFrame:CGRectMake(0, 0, 37, 37)];
    [_loading setCustomView:iv];
    [_loading setLabelText:labelText];
    [_loading setMode:model];
}

/**
 * hide progress from view
 */
+ (void)hideProgressWithAnimated:(BOOL)isAnimated
{
    if (nil != _hideProgressTimer && [_hideProgressTimer isValid])
    {
        [_hideProgressTimer invalidate];
    }
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [MBProgressHUD hideHUDForView:window animated:isAnimated];
}
#pragma mark - for userdefault
/**
 * add data to userdefault
 */
+ (void)addDataToUserDefaultWithObj:(id)obj withKey:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (ud)
    {
        [ud setObject:obj forKey:key];
    }
    [ud synchronize];
}

/**
 * get data from userdefault
 */
+ (id)getDataFromUserDefaultWithKey:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (ud)
    {
        return [ud objectForKey:key];
    }
    return nil;
}

/**
 * confirm email is ture
 */
+(BOOL)isEmail:(NSString *)email
{
    return [email isMatchedByRegex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

+ (void)showAlertViewForErrorWithType:(int)type
{
    NSString *message = nil;
    switch (type)
    {
        case 200:
            message = @"请求成功";
            break;
        case 401:
            message = @"密码不正确";
            break;
        case 402:
            message = @"您的权限不够";
            break;
        case 404:
            message = @"用户名不存在";
            break;
        case 900:
            message = @"当前无网络";
            break;
        default:
            message = @"请求失败";
            break;
    }
    [CommonHelpers showAlertViewWithType:MyAlertViewTypeSad andWithMessage:message andWithImageNameForButton:nil andWithInView:nil];
}

@end
