//
//  GlobalUrl.h
//  Communication
//
//  Created by 远超 李 on 13-8-18.
//  Copyright (c) 2013年 jonanth. All rights reserved.
//

#define UrlForMainPath        @"http://www.zerodesign.net.cn/maibo_server/index.php/api"

typedef enum
{
    UrlForLogin,
    UrlForLogout,
    UrlForRegister,
    UrlForCompany,
    UrlForAvatar,
    UrlForChangePassWord,
    UrlForForgetPassWord,
    UrlForVerification,
    UrlForCommunicationList,
    UrlForStatistic,
    UrlForCommunicationAnswer,
    UrlForFeelingList,
    UrlForFeelingCreate,
    UrlForTalkList
}UrlType;

CG_INLINE NSString * getUrlWithType(int type)
{
    NSString *url = nil;
    switch (type)
    {
        case UrlForLogin:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/account/login"];
            break;
        case UrlForLogout:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/account/login_out"];
            break;
        case UrlForRegister:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/account/register"];
            break;
        case UrlForCompany:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/account/company"];
            break;
        case UrlForAvatar:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/account/avatar"];
            break;
        case UrlForChangePassWord:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/account/change_password"];
            break;
        case UrlForForgetPassWord:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/account/forget_password"];
            break;
        case UrlForVerification:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/verification/check"];
            break;
        case UrlForCommunicationList:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/communication/list"];
            break;
        case UrlForStatistic:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/communication/statistics"];
            break;
        case UrlForCommunicationAnswer:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/communication/answer"];
            break;
        case UrlForFeelingList:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/feeling/list"];
            break;
        case UrlForFeelingCreate:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/feeling/create"];
            break;
        case UrlForTalkList:
            url = [NSString stringWithFormat:@"%@%@", UrlForMainPath, @"/talk/list"];
            break;
        default:
            break;
    }
    return url;
}

@interface GlobalUrl : NSObject

@end