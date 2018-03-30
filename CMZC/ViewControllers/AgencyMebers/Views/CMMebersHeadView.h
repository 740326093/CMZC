//
//  CMMebersHeadView.h
//  CMZC
//
//  Created by WangWei on 2018/2/1.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMAgenceMemberModel.h"
@interface CMMebersHeadView : UIView
@property(nonatomic,assign)id delegate;
@property(nonatomic,strong)CMAgenceMemberModel *AgenceMemberModel;
@end

@protocol  CMMebersHeadView<NSObject>
-(void)enterMyApplyListWithType:(NSInteger)type;
@end
