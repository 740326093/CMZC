//
//  CMRequestAPI+Product.h
//  CMZC
//
//  Created by 财猫 on 16/4/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  申购

#import "CMRequestAPI.h"


@class CMProductDetails;
@interface CMRequestAPI (Product)
/**
 *  获得申购列表数据
 *
 *  @param page    页码
 *  @param size
 */
+ (void)cm_applyFetchProductListOnPageIndex:(NSInteger)page
                                   pageSize:(NSInteger)size
                                    success:(void(^)(NSArray *productArr,BOOL isPage))success
                                       fail:(void(^)(NSError *error))fail;


+ (void)cm_applyFetchProductDetailsListProductId:(NSInteger)productId
                                         success:(void(^)(CMProductDetails *listArr))success
                                            fail:(void(^)(NSError *error))fail;


/**
 *  获得申购产品收藏
 *
 *  @param type    0 查询是否收藏 1 收藏 2取消收藏
 *  @param hyid    会员编码
    @param cpid    产品编码
 */
+ (void)cm_applyFetchProductDetailsCollectWithType:(NSInteger)type andProductID:(NSInteger)producID success:(void (^)(id isSuccess))success fail:(void (^)(NSError *))fail;
@end
