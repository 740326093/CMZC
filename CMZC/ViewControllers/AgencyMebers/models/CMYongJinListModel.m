//
//  CMYongJinListModel.m
//  CMZC
//
//  Created by WangWei on 2018/3/22.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMYongJinListModel.h"

@implementation CMYongJinListModel
-(UIColor*)statusLabColor{
    
    if ([_JieSuanStatus isEqualToString:@"未结算"]) {
        return [UIColor clmHex:0xff0000];
    }else{
        
        return [UIColor clmHex:0x999999];
    }
}
@end
