//
//  CMNewShiModel.h
//  CMZC
//
//  Created by WangWei on 17/2/24.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMNewShiModel : NSObject

@property (nonatomic,assign) NSInteger mediaId; //新闻id
@property (nonatomic,copy) NSString *title; //标题
@property (nonatomic,copy) NSString *picture; //媒体新闻图片地址
@property (nonatomic,copy) NSString *descrip; //新闻简述
@property (nonatomic,copy) NSString *link;  //点击后获得的新闻地址
@property (nonatomic,copy) NSString *created;  //发布日期


@end
