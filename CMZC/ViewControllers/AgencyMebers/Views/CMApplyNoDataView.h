//
//  CMApplyNoDataView.h
//  CMZC
//
//  Created by WangWei on 2018/2/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMApplyNoDataView : UIView

-(void)updateNoDataImage:(NSString*)imageStr andnoDataTitle:(NSString*)title withApplyString:(NSString*)applyStr;
@property(nonatomic,weak)id delegate;
@end
@protocol CMApplyNoDataViewDelegate<NSObject>
-(void)applyEvent;
@end
