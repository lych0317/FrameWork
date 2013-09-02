
#import "BaseStore.h"

@implementation BaseStore

- (NSDictionary *)goToServiceWithUrl:(NSString *)url
               andWithAuthentication:(NSDictionary *)authentication
                       andWithHeader:(NSDictionary *)header
                         andWithBody:(NSDictionary *)body
{
    NSString *responseString = nil;
    if (NetWorkStatusNone == [CommonHelpers getCurrentNetworkStatus])
    {
        responseString = [NSString stringWithFormat:kHTTPRequestFormater, CodeForResultTypeNoNetWork, getMessageForResultFromCode(CodeForResultTypeNoNetWork)];
    }
    else
    {
        ASIHTTPRequest *request = nil;
        if (!body)
        {
            request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
        }
        else
        {
            request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
            request.shouldAttemptPersistentConnection = NO;//不支持长连接
            NSString *keyName = nil;
            NSEnumerator *bodyEnum = [body keyEnumerator];
            while ((keyName = bodyEnum.nextObject) != nil)
            {
                if ([keyName isEqualToString:@"avatar"])
                {
//                    [(ASIFormDataRequest *)request setFile:[body objectForKey:keyName] forKey:keyName];
                    [(ASIFormDataRequest *) request addData:[body objectForKey:keyName] withFileName:@"avatar.jpeg" andContentType:@"image/jpeg" forKey:@"avatar"];
                }
                else
                {
                    [(ASIFormDataRequest *)request setPostValue:[body objectForKey:keyName] forKey:keyName];
                }
            }
            [request buildPostBody];
            request.uploadProgressDelegate = nil;
        }
        if (authentication)
        {
            [request addBasicAuthenticationHeaderWithUsername:authentication[kAuthenticationForUserName]
                                                  andPassword:authentication[kAuthenticationForPassWord]];
        }
        if (header)
        {
            NSEnumerator *keyEnum = [header keyEnumerator];
            NSString *keyName = nil;
            while ((keyName = keyEnum.nextObject) != nil)
            {
                [request addRequestHeader:keyName value:[header objectForKey:keyName]];
            }
        }
        [request startSynchronous];
        int code = request.responseStatusCode;
        if (code == 200)
        {
            NSString *tmpResponseString = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
            if (tmpResponseString != nil && ![@"" isEqualToString:tmpResponseString])
            {
                responseString = [NSString stringWithFormat:@"{\"responseCode\":\"%d\",\"responseMessage\":%@}", code, tmpResponseString];
            }
            else
            {
                responseString = [NSString stringWithFormat:kHTTPRequestFormater, CodeForResultTypeNoData, getMessageForResultFromCode(CodeForResultTypeNoData)];
            }
        }
        else
        {
            responseString = [NSString stringWithFormat:kHTTPRequestFormater, code, getMessageForResultFromCode(code)];
        }
    }
    return [responseString objectFromJSONString];
}

@end
