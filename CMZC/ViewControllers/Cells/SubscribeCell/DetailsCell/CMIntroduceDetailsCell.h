//
//  CMIntroduceDetailsCell.h
//  CMZC
//
//  Created by MAC on 16/10/8.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMProductDetails;
@protocol CMIntroduceDetailsCellDelegate <NSObject>
/**
 *  切换一个地址
 *
 *  @param index 切换图片
 */
- (void)cm_toggleDisplayContentIndex:(NSInteger)index;

@end


@interface CMIntroduceDetailsCell : UITableViewCell

@property (nonatomic,assign)id<CMIntroduceDetailsCellDelegate>delegate;

@property (strong, nonatomic) CMProductDetails *productDetails;

@end
