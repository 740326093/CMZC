//
//  CMNewCommentTableViewCell.h
//  CMZC
//
//  Created by MAC on 16/11/30.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMProductNotion;
@class CMAnalystPoint;
@interface CMNewCommentTableViewCell : UITableViewCell

@property (strong, nonatomic) CMProductNotion *productNotion; //公告
@property (strong, nonatomic) CMAnalystPoint *analystPoint; //评论
@property (nonatomic,copy) NSString *introduceStr; // 企业介绍详情

@end
