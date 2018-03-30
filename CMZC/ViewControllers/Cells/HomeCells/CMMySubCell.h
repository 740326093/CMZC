//
//  CMMySubCell.h
//  CMZC
//
//  Created by WangWei on 2017/12/5.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMMySubCell : UITableViewCell

/**
 *  传入数据
 *
 *  @param titName 名字lab
 *  @param imgName 图片的名字
 */
- (void)cm_functionTileLabNameStr:(NSString *)titName
                   titleImageName:(NSString *)imgName;
@end
