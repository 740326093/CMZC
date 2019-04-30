//
//  CMRequestAPI+Trends.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMRequestAPI+Trends.h"


#import "CMNewShiModel.h"
@implementation CMRequestAPI (Trends)

////媒体报道
//+ (void)cm_trendsFetchMediaCoverDataPage:(NSInteger)page pageSize:(NSInteger)size success:(void (^)(NSArray *,BOOL))success fail:(void (^)(NSError *))fail {
//    NSDictionary *arguments = @{@"pageindex":CMNumberWithFormat(page),
//                                @"pagesize":CMNumberWithFormat(size)
//                                };
//
//    [CMRequestAPI postDataFromURLScheme:kCMTrendsMediaCoverURL argumentsDictionary:arguments success:^(id responseObject) {
//        NSArray *newsArr = responseObject[@"data"][@"rows"];
//        NSMutableArray *mediaArr = [NSMutableArray array];
//        for (NSDictionary *dict in newsArr) {
//            CMMediaNews *mediaNews = [CMMediaNews yy_modelWithDictionary:dict];
//            [mediaArr addObject:mediaNews];
//        }
//        NSInteger total = page * 10;
//        BOOL isPage = NO;
//        if (total > [responseObject[@"page"] integerValue]) {
//            isPage = YES;
//        }
//        
//        success(mediaArr,isPage);
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//    
//}

////公告
//+ (void)cm_trendsFetchNoticeDataPage:(NSInteger)page success:(void (^)(NSArray *,BOOL))success fail:(void (^)(NSError *))fail {
//    NSDictionary *arguments = @{@"pageindex":CMNumberWithFormat(page),
//                               // @"pagesize":CMNumberWithFormat()
//                                };
//    [CMRequestAPI postDataFromURLScheme:kCMTrendsNoticeURL argumentsDictionary:arguments success:^(id responseObject) {
//        NSArray *noticeArr = responseObject[@"data"][@"rows"];
//        NSMutableArray *noticeModeArr = [NSMutableArray array];
//        for (NSDictionary *dict in noticeArr) {
//            CMNoticeModel *not = [CMNoticeModel yy_modelWithDictionary:dict];
//            [noticeModeArr addObject:not];
//        }
//        NSInteger total = page * 10;
//        BOOL isPage = NO;
//        if (total > [responseObject[@"total"] integerValue]) {
//            isPage = YES;
//        }
//        success(noticeModeArr,isPage);
//        
//    } fail:^(NSError *error) {
//        fail(error);
//    }];
//    
//}
+ (void)cm_trendsNewDataPage:(NSInteger)page withType:(NSString*)type
                     success:(void(^)(NSArray *dataArr,BOOL isPage))success
                        fail:(void(^)(NSError *error))fail{
    
    NSDictionary *arguments = @{@"pageindex":CMNumberWithFormat(page),
                                @"type":type
                                };
   
    [CMRequestAPI postDataFromURLScheme:kCMTrendsNewActionURL argumentsDictionary:arguments success:^(id responseObject) {
     //MyLog(@"xinguandian+++%@",responseObject);
        NSArray *noticeArr = responseObject[@"data"][@"rows"];
        NSMutableArray *noticeModeArr = [NSMutableArray array];
        for (NSDictionary *dict in noticeArr) {
            CMNewShiModel *not = [CMNewShiModel yy_modelWithDictionary:dict];
            [noticeModeArr addObject:not];
        }
        NSInteger total = page * 10;
        BOOL isPage = NO;
        if (total > [responseObject[@"total"] integerValue]) {
            isPage = YES;
             if ([responseObject[@"data"][@"page"] integerValue]*noticeModeArr.count<total) {
                 isPage = NO;
            }
        }
        success(noticeModeArr,isPage);
        
    } fail:^(NSError *error) {
        fail(error);
    }];

}

+ (void)cm_upLoadPic:(UIImage*)image
             success:(void(^)(NSString *urlPath))success
                fail:(void(^)(NSError *error))fail{
    
    
    
    NSDictionary *arguments = @{@"content":[NSString base64WithString:image]};
    
    [CMRequestAPI postDataFromURLScheme:KCMUpLoadImageURL argumentsDictionary:arguments success:^(id responseObject) {
        MyLog(@"上传图片+++%@",responseObject);
        
        if ([[responseObject objectForKey:@"errcode"]intValue]==0) {
           
            
            NSString *path=[responseObject objectForKey:@"data"];
            success(path);
        }
      
       
        
    } fail:^(NSError *error) {
        fail(error);
    }];

    
    
}

@end
