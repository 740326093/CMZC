//
//  CMAssociateDetailCell.h
//  CMZC
//
//  Created by WangWei on 2018/2/2.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMAssociateDetailCell : UITableViewCell

@property(nonatomic,copy)NSString *leftImage;
@property(nonatomic,copy)NSString *leftTitle;
@property(nonatomic,copy)NSString *leftDetail;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabe;

@end
