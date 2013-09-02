
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

//服务端返回的JSON字符串格式
#define kResponseCode              @"responseCode"
#define kResponseMessage           @"responseMessage"
#define kHTTPRequestFormater       @"{\"responseCode\":\"%d\",\"responseMessage\":\"%@\"}"
#define kAuthenticationForUserName @"UserName"
#define kAuthenticationForPassWord @"PassWord"

typedef enum {
    CodeForResultTypeSuccess            = 200,     // success
    CodeForResultTypeWrongPwd           = 401,     // the password is wrong
    CodeForResultTypeOutLimit           = 402,     // out of limit
    CodeForResultTypeNoUser             = 404,     // don't have this user name
    CodeForResultTypeNoNetWork          = 900,     // don't have net work
    CodeForResultTypeNoData             = 901      // request is success but no data
}CodeForResultType;

CG_INLINE NSString * getMessageForResultFromCode(NSInteger code)
{
    NSString *msg = nil;
    switch (code)
    {
        case CodeForResultTypeSuccess:
            msg = @"请求成功";
            break;
        case CodeForResultTypeWrongPwd:
            msg = @"密码错误";
            break;
        case CodeForResultTypeNoUser:
            msg = @"用户不存在";
            break;
        case CodeForResultTypeNoNetWork:
            msg = @"网络不存在";
            break;
        default:
            msg = @"未知错误";
            break;
    }
    return msg;
}

typedef enum {
    RequestMethodTypeGet,
    RequestMethodTypePost
}RequestMethodType;

@interface BaseStore : NSObject

- (NSDictionary *)goToServiceWithUrl:(NSString *)url
               andWithAuthentication:(NSDictionary *)authentication
                       andWithHeader:(NSDictionary *)header
                         andWithBody:(NSDictionary *)body;

@end
