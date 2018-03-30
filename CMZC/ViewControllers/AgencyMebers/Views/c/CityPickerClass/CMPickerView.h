//
//  CMPickerView.h
//  CMZC
//
//  Created by WangWei on 2018/2/6.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CMPickerView : UIView
//@property(nonatomic,copy)void(^lz_backBlock)(NSString *address);
@property(nonatomic,weak)id delegate;
@end
@protocol  CMPickerDelegate <NSObject>
-(void)backProviceMessage:(NSString*)message andProviceCode:(NSString*)proviceCode andCityCode:(NSString*)cityCode withDistCode:(NSString*)distCode;
@end
