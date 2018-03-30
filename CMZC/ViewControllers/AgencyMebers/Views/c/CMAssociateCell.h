//
//  CMAssociateCell.h
//  CMZC
//
//  Created by WangWei on 2018/2/2.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMAgenceMemberModel.h"
@interface CMAssociateCell : UITableViewCell

@property(nonatomic,assign)id delegate;
@property(nonatomic,strong)CMAgenceMemberModel *agencyModel;
@end
@protocol CMAssociateCellDelegate <NSObject>

-(void)callManagerEvent;
@end
