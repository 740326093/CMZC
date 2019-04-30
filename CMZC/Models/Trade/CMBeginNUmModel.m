//
//  CMBeginNUmModel.m
//  CMZC
//
//  Created by WangWei on 2019/4/13.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import "CMBeginNUmModel.h"

@implementation CMBeginNUmModel
-(UIColor*)statusColor{
    
//    if (_status==0) {
//        return [UIColor blackColor];
//    } else if(_status==1){
//        return [UIColor greenColor];
//    }else if(_status==2){
//        return [UIColor grayColor];
//    }else if(_status==3){
//        return [UIColor redColor];
//    }else {
//        return [UIColor clmHex:0x999999];
//    }
    if(_status==1){
        return [UIColor redColor];
    }else{
        return [UIColor blackColor];
        
        
    }
    
    
}
@end
