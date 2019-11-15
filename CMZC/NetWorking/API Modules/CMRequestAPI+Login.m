//
//  CMRequestAPI+Login.m
//  CMZC
//
//  Created by 财猫 on 16/3/21.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMRequestAPI+Login.h"
#import "CMAccount.h"

@implementation CMRequestAPI (Login)
//注册登录
+ (void)cm_loginTransferDataPhoneNumber:(NSInteger)number phoneVercode:(NSInteger)vercode password:(NSString *)pasword confimPassword:(NSString *)confimPasword success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"username":CMNumberWithFormat(number),
                           @"vercode":CMNumberWithFormat(vercode),
                           @"password":pasword,
                           @"confimpassword":confimPasword,
                           @"channel":@"3"
                           };
    
    [CMRequestAPI postDataFromURLScheme:kCMRegisterURL argumentsDictionary:dict success:^(id responseObject) {
        
        success(YES);
    } fail:^(NSError *error) {
        
        fail(error);
    }];
    
}

//重置密码
+ (void)cm_loginTransferResetPhoneNumber:(NSInteger)number phoneVercode:(NSInteger)vercode password:(NSString *)password confimPassword:(NSString *)confimPasword success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"phonenumber":CMNumberWithFormat(number),
                           @"vercode":CMNumberWithFormat(vercode),
                           @"password":password,
                           @"confimpassword":confimPasword
                           };
    
    [CMRequestAPI postDataFromURLScheme:kCMResetPasswordURL argumentsDictionary:dict success:^(id responseObject) {
        success(YES);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}

//登录
+ (void)cm_loginTransRegisterClientId:(NSString *)clientId clientSecret:(NSString *)secret userName:(NSString *)number password:(NSString *)password success:(void (^)(CMAccount *))success fail:(void (^)(NSError *error,NSDictionary *errorDict))fail {
    
    
    NSDictionary *dict = @{
                           @"client_id":clientId,
                           @"client_secret":secret,
                           @"grant_type":@"password",
                           @"username":number,
                           @"Password":password,
                           @"platform":@"1"
                           };
    NSMutableDictionary *MutableDict=[NSMutableDictionary dictionaryWithDictionary:dict];
    if ([JPUSHService registrationID]) {
        
        [MutableDict setObject:[JPUSHService registrationID] forKey:@"id"];
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPMaximumConnectionsPerHost = 8;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kCMBaseApiURL] sessionConfiguration:configuration];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript", @"text/plain", @"text/html",nil];

    NSURLSessionDataTask *dataTask = [manager POST:kCMLoginURL parameters:MutableDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"errcode"] integerValue] == 0) {
            //删除
            DeleteDataFromNSUserDefaults(@"value");
            DeleteDataFromNSUserDefaults(@"userid");
            //获得cookies
            NSDictionary *fields = [(NSHTTPURLResponse *)task.response allHeaderFields];
          //  NSLog(@"fields :%@",fields);
           //  NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:kCMBaseApiURL]];
  
             //NSHTTPCookie *cookie = cookies.firstObject;
  
            
        NSString *cookieString = [fields valueForKey:@"Set-Cookie"];
        
            
        NSArray *arr= [cookieString componentsSeparatedByString:@";"];
        NSString *newString=arr.firstObject;
        NSArray *arr1= [newString componentsSeparatedByString:@"="];
      // MyLog(@"++%@",newString);
           // if(cookie.name&&cookie.value){
           // SaveDataToNSUserDefaults(cookie.name, @"name");
           // SaveDataToNSUserDefaults(cookie.value, @"value");
           // }else{
                SaveDataToNSUserDefaults(arr1.firstObject, @"name");
               SaveDataToNSUserDefaults(arr1.lastObject, @"value");
              SaveDataToNSUserDefaults(newString, @"Set-Cookie");
            
            //}
            //存储以下当前时间
            SaveDataToNSUserDefaults([NSDate date], kVerifyStareDateKey);
            
            CMAccount *account = [[CMAccount alloc] initWithDict:responseObject];
            
            success(account);
        } else {
            NSError *cmError = [NSError errorWithDomain:responseObject[@"errmsg"] code:[responseObject[@"errcode"] integerValue] message:[NSString errorMessageWithCode:[responseObject[@"errcode"] integerValue]]];
            fail(cmError,@{});
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code==-1011) {
            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSDictionary *body = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
            
            if (body) {
                
               fail(error,body);
            }
        }else{
            //请求失败
            NSError *cmError = [NSError errorWithDomain:error.domain code:error.code message:[NSString errorMessageWithCode:error.code]];
            fail(cmError,@{});
        }
        
        
        
    }];
    
    [dataTask resume];
    
}

//获取短信验证码
+ (void)cm_toolFetchShortMessagePhoneNumber:(NSInteger)number success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{@"phone":CMNumberWithFormat(number)};
    
    [CMRequestAPI postDataFromURLScheme:kCMShortMessageURL argumentsDictionary:dict success:^(id responseObject) {
        
        success(YES);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//刷新token 的方法
+ (void)cm_toolFetchRefreshToken:(NSString *)refreshToken success:(void (^)(BOOL))success fail:(void (^)(NSError *error,NSDictionary *errorDict))fail {
    
   
    NSDictionary *dict = @{
                          
                           @"grant_type":@"refresh_token",
                    //@"client_id":@"CC67712F-4614-40CF-824E-10D784C2A3D7",
                         //@"client_secret":@"c0aa7577b892ff2ff4ee0109f2932321",
                           
                           @"refresh_token":refreshToken
                          
                           };
    
 
  

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPMaximumConnectionsPerHost = 8;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kCMBaseApiURL] sessionConfiguration:configuration];
 
    NSString *encondStr=[NSString stringWithFormat:@"%@:%@",@"CC67712F-4614-40CF-824E-10D784C2A3D7",@"c0aa7577b892ff2ff4ee0109f2932321"];
    NSData *encodeData = [encondStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [encodeData base64Encoding];
    NSString *baseString=[NSString stringWithFormat:@"Basic %@",base64String];
    [manager.requestSerializer setValue:baseString forHTTPHeaderField:@"Authorization"];

    
    
    NSURLSessionDataTask *dataTask = [manager POST:kCMLoginURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        NSString *token =responseObject[@"refresh_token"];
          MyLog(@"刷新token++++%@",responseObject)
        if (token.length>0) {
            //删除
            //DeleteDataFromNSUserDefaults(@"name");
           // DeleteDataFromNSUserDefaults(@"value");
            
            //获得cookies
            NSDictionary *fields = [(NSHTTPURLResponse *)task.response allHeaderFields];
            //NSLog(@"fields :%@",fields);
          //  NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:kCMBaseApiURL]];
            
           // NSHTTPCookie *cookie = cookies.firstObject;
            //保存到本地
            
            NSString *cookieString = [fields valueForKey:@"Set-Cookie"];
           
            NSArray *arr= [cookieString componentsSeparatedByString:@";"];
            NSString *newString=arr.firstObject;
            
            SaveDataToNSUserDefaults(newString, @"Set-Cookie");
            
           NSArray *arr1= [newString componentsSeparatedByString:@"="];
            
//            if(cookie.name&&cookie.value){
              SaveDataToNSUserDefaults(arr1.firstObject, @"name");
               SaveDataToNSUserDefaults(arr1.lastObject, @"value");
//            }else{
               // SaveDataToNSUserDefaults(arr1.firstObject, @"name");
                //SaveDataToNSUserDefaults(arr1.lastObject, @"value");
        //    }
            
            
            
            
            //保存到本地
//            SaveDataToNSUserDefaults(cookie.name, @"name");
//            SaveDataToNSUserDefaults(cookie.value, @"value");
    
            
            CMAccount *account = [[CMAccount alloc] initWithDict:responseObject];
            account.userName = GetDataFromNSUserDefaults(@"accountName");
            //account.password = pasw;
            [[CMAccountTool sharedCMAccountTool] addAccount:account];
            success(YES);
        } else {
            
      NSError *cmError = [NSError errorWithDomain:responseObject[@"errmsg"] code:[responseObject[@"errcode"] integerValue] message:[NSString errorMessageWithCode:[responseObject[@"errcode"] integerValue]]];
            fail(cmError,@{});
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
      
        if (error.code==-1011) {
            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSDictionary *body = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
             MyLog(@"error:%@",body);
            if (body) {
                
                fail(error,body);
            }
        }else{
            //请求失败
            NSError *cmError = [NSError errorWithDomain:error.domain code:error.code message:[NSString errorMessageWithCode:error.code]];
            fail(cmError,@{});
        }
    }];
    
    [dataTask resume];
    
    
}

+ (void)cm_toolFetchShortMessagePhoneNumber:(NSString*)number andGestureToken:(NSString*)token
                                    success:(void(^)(BOOL isSucceed))success
                                       fail:(void(^)(NSError *error))fail{
    
    
    
    NSDictionary *dict = @{@"phone":number,@"token":token,@"type":@"xjbapp",@"scene":@"1",@"vid":VPSDKAppKey};
    
    [CMRequestAPI postDataFromURLScheme:KGetPhoneSMSCodeURL argumentsDictionary:dict success:^(id responseObject) {
        //MyLog(@"获取短信+++%@",responseObject);
        
        if([responseObject[@"errcode"]integerValue]==0){
          success(YES);
        }
        
    } fail:^(NSError *error) {
        
        fail(error);
    }];
    
    
}

+ (void)cm_toolFetchShortMessageLogin:(NSString*)number andSMSCode:(NSString*)code
                              success:(void(^)(CMAccount *account))success
                                 fail:(void(^)(NSError *error,NSDictionary *errorDict))fail{
    
    NSDictionary *dict = @{
                @"client_id":@"CC67712F-4614-40CF-824E-10D784C2A3D7",
                  @"client_secret":@"c0aa7577b892ff2ff4ee0109f2932321",
                           @"grant_type":@"password",
                           @"username":number,
                           @"password":@"",
                           @"Vercode":code,
                           @"loadtype":@"vercode",
                           @"platform":@"1"
                           };
    NSMutableDictionary *MutableDict=[NSMutableDictionary dictionaryWithDictionary:dict];
    if ([JPUSHService registrationID]) {

        [MutableDict setObject:[JPUSHService registrationID] forKey:@"id"];
    }
    
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPMaximumConnectionsPerHost = 8;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kCMBaseApiURL] sessionConfiguration:configuration];
    
    
//    NSString *encondStr=[NSString stringWithFormat:@"%@:%@",@"CC67712F-4614-40CF-824E-10D784C2A3D7",@"c0aa7577b892ff2ff4ee0109f2932321"];
//    NSData *encodeData = [encondStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *base64String = [encodeData base64Encoding];
//    NSString *baseString=[NSString stringWithFormat:@"Basic %@",base64String];
//    [manager.requestSerializer setValue:baseString forHTTPHeaderField:@"Authorization"];

//
    NSURLSessionDataTask *dataTask = [manager POST:kCMLoginURL parameters:MutableDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"errcode"] integerValue] == 0) {
            //删除
            DeleteDataFromNSUserDefaults(@"value");
            DeleteDataFromNSUserDefaults(@"userid");
            //获得cookies
            NSDictionary *fields = [(NSHTTPURLResponse *)task.response allHeaderFields];
            //  NSLog(@"fields :%@",fields);
           // NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:kCMBaseApiURL]];
            
           // NSHTTPCookie *cookie = cookies.firstObject;
            //保存到本地
            
            NSString *cookieString = [fields valueForKey:@"Set-Cookie"];
            
            NSArray *arr= [cookieString componentsSeparatedByString:@";"];
            NSString *newString=arr.firstObject;
            SaveDataToNSUserDefaults(newString, @"Set-Cookie");
           NSArray *arr1= [newString componentsSeparatedByString:@"="];
            
//            if(cookie.name&&cookie.value){
          //    SaveDataToNSUserDefaults(cookie.name, @"name");
            //    SaveDataToNSUserDefaults(cookie.value, @"value");
//            }else{
                SaveDataToNSUserDefaults(arr1.firstObject, @"name");
                SaveDataToNSUserDefaults(arr1.lastObject, @"value");
           // }
            //存储以下当前时间
            SaveDataToNSUserDefaults([NSDate date], kVerifyStareDateKey);
            
            CMAccount *account = [[CMAccount alloc] initWithDict:responseObject];
            
            success(account);
        } else {
            
            NSError *cmError = [NSError errorWithDomain:responseObject[@"errmsg"] code:[responseObject[@"errcode"] integerValue] message:[NSString errorMessageWithCode:[responseObject[@"errcode"] integerValue]]];
            fail(cmError,@{});
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        if (error.code==-1011) {
            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSDictionary *body = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
            
            if (body) {
                
                fail(error,body);
            }
        }else{
            //请求失败
            NSError *cmError = [NSError errorWithDomain:error.domain code:error.code message:[NSString errorMessageWithCode:error.code]];
            fail(cmError,@{});
        }
    }];
    
    [dataTask resume];
    
    
    
}
@end



















