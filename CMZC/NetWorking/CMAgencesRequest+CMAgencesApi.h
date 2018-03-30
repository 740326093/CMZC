//
//  CMAgencesRequest+CMAgencesApi.h
//  CMZC
//
//  Created by WangWei on 2018/2/28.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMAgencesRequest.h"

@interface CMAgencesRequest (CMAgencesApi)

//机构会员请求省份
-(void)requestProvicessuccess:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
//机构会员请求市县
-(void)requestCityWithCode:(NSString*)code success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

//机构会员申请
-(void)AgencyMebersApplyWithApi:(NSString*)api andMessage:(NSDictionary*)messageDict success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

-(void)becomeAgencyMebersWithApi:(NSString*)api andMessage:(NSDictionary*)messageDict andLogo:(NSString*)imageStr success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

@end
