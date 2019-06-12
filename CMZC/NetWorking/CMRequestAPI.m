//
//  CMRequestAPI.m
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMRequestAPI.h"
#import "CMNoNetworkView.h"
typedef NS_ENUM(NSUInteger, CMHTTPRequestStatusCode) {
    CMHTTPRequestStautsCodeOf = 200,
    CMHTTPRequestStatusCodeNotFound = 404
};


@interface CMRequestAPI ()
{
    AFHTTPSessionManager *_manager;
    AFURLSessionManager *_manage;
}
@property (strong, nonatomic) CMNoNetworkView *NoNetworkView;
@end


@implementation CMRequestAPI



//  不加token的 Post通用请求
+ (void)postDataFromURLScheme:(NSString *)urlScheme
          argumentsDictionary:(NSDictionary *)arguments
                      success:(SuccessRequestBlock)success
                         fail:(FailRequestBlock)fail
{
    NSParameterAssert(success);
    [[CMRequestAPI sharedAPI] postDataFromURLScheme:urlScheme argumentsDictionary:arguments success:success fail:fail];
}
//  需要加touken的post请求
+ (void)postTradeFromURLScheme:(NSString *)urlScheme argumentsDictionary:(NSDictionary *)arguments success:(SuccessRequestBlock)success fail:(FailRequestBlock)fail {
    NSParameterAssert(success);
    [[CMRequestAPI sharedAPI] postTradeFromURLScheme:urlScheme argumentsDictionary:arguments success:success fail:fail];
}
//  普通的post
+ (void)postOrdinaryFromURLScheme:(NSString *)urlScheme argumentsDictionary:(NSDictionary *)arguments success:(SuccessRequestBlock)success fail:(FailRequestBlock)fail {
    NSParameterAssert(success);
    [[CMRequestAPI sharedAPI] postOrdinaryFromURLScheme:urlScheme argumentsDictionary:arguments success:success fail:fail];
}

#pragma mark 没有网络设置
-(CMNoNetworkView*)NoNetworkView{
    if (!_NoNetworkView) {
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        //CGRect rectNav = self.navigationController.navigationBar.frame;
        
        _NoNetworkView=[CMNoNetworkView  initByNibForClassName];
        _NoNetworkView.frame=CGRectMake(0, rectStatus.size.height+44, CMScreen_width(), 50);
    }
    return _NoNetworkView;
}
-(void)NoNetWorkSetting{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.NoNetworkView];
}
//GET 请求通用
+ (void)getDataFromURLScheme:(NSString *)urlScheme argumentsDictionary:(NSDictionary *)arguments success:(SuccessRequestBlock)success fail:(FailRequestBlock)fail {
    NSParameterAssert(success);
    [[CMRequestAPI sharedAPI] getDataFromURLScheme:urlScheme argumentsDictionary:arguments success:success fail:fail];
}

#pragma mark - init && setup
+ (CMRequestAPI *)sharedAPI {
    static CMRequestAPI *_sharedRequestAPI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRequestAPI = [[CMRequestAPI alloc] init];
    });
    return _sharedRequestAPI;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPMaximumConnectionsPerHost = 8;
        _manage = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kCMBaseApiURL] sessionConfiguration:configuration];
    }
    return self;
}

//需要加入 请求头 touken 的post请求
- (void)postTradeFromURLScheme:(NSString *)urlScheme argumentsDictionary:(NSDictionary *)arguments success:(SuccessRequestBlock)success fail:(FailRequestBlock)fail {
    
    NSString *refreshToken = [CMAccountTool sharedCMAccountTool].currentAccount.access_token;
    
    NSString *string = [NSString stringWithFormat:@"Bearer %@",refreshToken];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kCMBaseApiURL,urlScheme];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:arguments error:nil];
    [request setValue:string forHTTPHeaderField:@"Authorization"];
    //_manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionTask *task = [_manage dataTaskWithRequest:request
                                         completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                             
                                             if (error) {
                                                
                                                 
                                                 NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                                                 NSDictionary *body = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
                                                 MyLog(@"error:%@",body);
                                                 //请求失败
                                                 NSError *cmError = [NSError errorWithDomain:error.domain code:error.code message:[NSString errorMessageWithCode:error.code]];
                                                 fail(cmError);
                                             } else {
                                                 
                                                 
                                                 if ([responseObject[@"errcode"] integerValue] == 0) {
                                                     //请求成功
                                                     success(responseObject);
                                                     [self.NoNetworkView removeFromSuperview];
                                                 } else {
                                                     
                                                     NSError *cmError = [NSError errorWithDomain:responseObject[@"errmsg"] code:[responseObject[@"errcode"] integerValue] message:[NSString errorMessageWithCode:[responseObject[@"errcode"] integerValue]]];
                                                     fail(cmError);
                                                 }
                                             }
                                         }];  
    [task resume];
}
//post 请求
- (void)postDataFromURLScheme:(NSString *)urlScheme
          argumentsDictionary:(NSDictionary *)arguments
                      success:(SuccessRequestBlock)success
                         fail:(FailRequestBlock)fail
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kCMBaseApiURL,urlScheme];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:arguments error:nil];
    NSURLSessionTask *task = [_manage dataTaskWithRequest:request
                                        completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                            
                                            if (error) {
                                                MyLog(@" error : %@",error);
                                                //请求失败
                                             
                                                NSError *cmError = [NSError errorWithDomain:error.domain code:error.code message:[NSString errorMessageWithCode:error.code]];
                                                fail(cmError);
                                            } else {
                                                if ([responseObject[@"errcode"] integerValue] == 0) {
                                                    //请求成功
                                                    success(responseObject);
                                                   [self.NoNetworkView removeFromSuperview];
                                                } else {
                                                    if ([responseObject[@"errcode"]integerValue] == 10120) {
                                                        NSError *error = [NSError errorResponseObject:responseObject];
                                                        
                                                        fail(error);
                                                    } else {
                                                        NSError *cmError = [NSError errorWithDomain:responseObject[@"errmsg"] code:[responseObject[@"errcode"] integerValue] message:[NSString errorMessageWithCode:[responseObject[@"errcode"] integerValue]]];
                                                        fail(cmError);
                                                    }
                                                }
                                                
                                            }
                                            
                                        }];
    [task resume];
    
}


//post 请求
- (void)postOrdinaryFromURLScheme:(NSString *)urlScheme
          argumentsDictionary:(NSDictionary *)arguments
                      success:(SuccessRequestBlock)success
                         fail:(FailRequestBlock)fail
{
    //添加一些公共请求部分
    
    //还要坐下登录判断，有些地方需要登录才能请求数据
    
    //请求数据
    NSURLSessionDataTask *dataTask = [_manager POST:urlScheme parameters:arguments progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"errcode"] integerValue] == 0) {
            //请求成功
           [self.NoNetworkView removeFromSuperview];
            success(responseObject);
        } else {
            if ([responseObject[@"errocode"]integerValue] == 10120) {
                NSError *error = [NSError errorResponseObject:responseObject];
                
                fail(error);
            } else {
                NSError *cmError = [NSError errorWithDomain:responseObject[@"errmsg"] code:[responseObject[@"errcode"] integerValue] message:[NSString errorMessageWithCode:[responseObject[@"errcode"] integerValue]]];
                fail(cmError);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@" error : %@",error);
        //请求失败
        NSError *cmError = [NSError errorWithDomain:error.domain code:error.code message:[NSString errorMessageWithCode:error.code]];
        fail(cmError);
    }];
    
    [dataTask resume];
}

//GET 请求
- (void)getDataFromURLScheme:(NSString *)urlScheme
         argumentsDictionary:(NSDictionary *)arguments
                     success:(SuccessRequestBlock)success
                        fail:(FailRequestBlock)fail
{
    
    NSString *refreshToken = [CMAccountTool sharedCMAccountTool].currentAccount.access_token;
    NSString *string = [NSString stringWithFormat:@"Bearer %@",refreshToken];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kCMBaseApiURL,urlScheme];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlStr parameters:arguments error:nil];
    [request setValue:string forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionTask *task = [_manage dataTaskWithRequest:request
                                        completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                            if (error) {
                                                MyLog(@" error : %@",error);
                                                //请求失败
                                                NSError *cmError = [NSError errorWithDomain:error.domain code:error.code message:[NSString errorMessageWithCode:error.code]];
                                                fail(cmError);
                                            } else {
                                                if ([responseObject[@"errcode"] integerValue] == 0) {
                                                    //请求成功
                                                  [self.NoNetworkView removeFromSuperview];
                                                    success(responseObject);
                                                } else {
                                                    NSError *cmError = [NSError errorWithDomain:responseObject[@"errmsg"] code:[responseObject[@"errcode"] integerValue] message:[NSString errorMessageWithCode:[responseObject[@"errcode"] integerValue]]];
                                                    fail(cmError);
                                                }
                                            }
                                        }];
    [task resume];
    
    
/*
    NSURLSessionDataTask *dataTask = [_manager GET:urlScheme parameters:arguments progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errcode"] integerValue] == 0) {
            //请求成功
            success(responseObject);
        } else {
            NSError *cmError = [NSError errorWithDomain:responseObject[@"errmsg"] code:[responseObject[@"errcode"] integerValue] message:[NSString errorMessageWithCode:[responseObject[@"errcode"] integerValue]]];
            fail(cmError);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"%@",error);
        //请求失败
        NSError *cmError = [NSError errorWithDomain:error.domain code:error.code message:[NSString errorMessageWithCode:error.code]];
        fail(cmError);
    }];
 
    
    [dataTask resume];
    */
    
    /*
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.上传文件
    NSDictionary *dict = @{@"username":@"1234"};
    
    NSString *urlString = @"22222";
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        //WKNSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        //WKNSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
       // WKNSLog(@"请求失败：%@",error);
    }];
    */
    
}

-(void)cheackNetWorking{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status==AFNetworkReachabilityStatusNotReachable){
            
            [self NoNetWorkSetting];
        }else{
            [self.NoNetworkView removeFromSuperview];
        
        }
    }];
    
    
    [manager startMonitoring];
    
    
    
    
}


@end






















