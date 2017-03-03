//
//  CMJSProtocol.h
//  CMZC
//
//  Created by WangWei on 17/3/1.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>



@protocol CMJSProtocol <NSObject,JSExport>

-(void)showShareView;


/**
 *  分享地址
 *
 *  @param title   标题
 *  @param content 描述
 *  @param site    链接地址
 *  @param picture 图片地址
 */
JSExportAs(share, - (void)share:(NSString *)title describeContent:(NSString *)content interlnkageSite:(NSString *)siteUrl pictureStie:(NSString *)pictureUrl);


@end

@interface CMJSProtocol : NSObject<CMJSProtocol>

@property (nonatomic,assign) id<CMJSProtocol>delegate;
@end
