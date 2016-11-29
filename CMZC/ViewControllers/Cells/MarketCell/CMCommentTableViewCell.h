//
//  CMCommentTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  行情详情的 评论 公告 企业信息 详情 cell

#import <UIKit/UIKit.h>
#import "CMTitleView.h"
#import "CMAnnounceView.h"
#import "CMCommentView.h"
#import "CMBusinessNewsView.h"
#import "CMProductNotion.h"
#import "CMProductComment.h"

@class CMProductNotion;
@class CMProductComment;


@protocol CMCommentTableViewCellDelegate <NSObject>
/**
 *  点击详情的时候跳转到M站
 */
- (void)cm_commentCellSkipBoundary;

/**
 *  跳转到评论详情
 *
 *  @param product 详情数据
 */
- (void)cm_commentViewControllProductNotion:(CMProductComment *)product;

/**
 *  跳转到公告详情页
 */
- (void)cm_commentNoticeViewNoticeId:(NSInteger)noticeId;


@end

@interface CMCommentTableViewCell : UITableViewCell

@property (nonatomic,assign)id<CMCommentTableViewCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet CMAnnounceView *announceView;//公告
@property (weak, nonatomic) IBOutlet CMCommentView *commentView; //评论
@property (weak, nonatomic) IBOutlet CMBusinessNewsView *businessView;//企业信息
@property (nonatomic,copy) NSString *code;

@end
