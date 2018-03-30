//
//  CMAgencesRequest.m
//  CMZC
//
//  Created by WangWei on 2018/2/28.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMAgencesRequest.h"

@implementation CMAgencesRequest

+ (CMAgencesRequest *)sharedAPI {
    static CMAgencesRequest *_sharedRequestAPI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRequestAPI = [[CMAgencesRequest alloc] init];
    });
    return _sharedRequestAPI;
}


+ (void)GETWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure{
    NSString *baseUrl=CMStringWithPickFormat(kCMNewMembersBase_URL,url);
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 30.f;
   [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer=response;
   // mgr.responseSerializer=[AFHTTPResponseSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json;encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript", @"text/plain", @"text/html",nil];
    
    [mgr GET:baseUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            //          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            //
            
            success(responseObject);
            //success(json);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            
            failure(error);
        }
    }];
    
}

+ (void)PostWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure{
    NSString *baseUrl=CMStringWithPickFormat(kCMNewMembersBase_URL,url);
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 30.f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
  //  mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    
  // mgr.responseSerializer= [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];

  
   // [mgr.requestSerializer setValue:@"application/json;encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
   // [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  // mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript", @"text/plain", @"text/html",nil];
    
   
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:baseUrl parameters:params error:nil];
      mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionTask *task = [mgr dataTaskWithRequest:request
                               completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                   
                                   if(success){
                                   NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                   NSDictionary *dict=[NSString dictionaryWithJsonString:str];
                                       success(dict);
                                   }
                                            
                                        }];
    [task resume];
    

    

/*
    [mgr POST:baseUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        if (success) {
//            
         NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
           NSDictionary *dict=[NSString dictionaryWithJsonString:str];
        MyLog(@"++++%@",dict);
//            
//            success(dict);
//            //success(json);
//        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            
            failure(error);
            
        }
    }];
   */
}
@end
