//
//  CMAgencyMessageCell.h
//  CMZC
//
//  Created by WangWei on 2018/2/1.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
@protocol CMAgencyMessageCellDelegate <NSObject>

//-(void)UploadMessage;
//-(void)selectAddressEvent;
//-(void)upIconPhoto;
@end
 */
@interface CMAgencyMessageCell : UITableViewCell
//@property(nonatomic,assign)id <CMAgencyMessageCellDelegate>delegate;
//@property(nonatomic,assign)NSInteger modelIndex;
//@property(nonatomic,copy)NSString *selectAddress;
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)CMAgencyMebersController *AgencyMebersController;
@end
