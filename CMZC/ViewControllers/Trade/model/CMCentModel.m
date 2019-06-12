//
//  CMCentModel.m
//  CMZC
//
//  Created by 云财富 on 2019/6/3.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMCentModel.h"

@implementation CMCentModel
-(NSString*)scPhone{
    
   
     return    [_scPhone  stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
  
}

-(NSString*)scTime{
    
    
    return    [self  timeChange:_scTime];
    
}
-(NSString*)scExpectAmount{
    
    
    return [[@"预分佣:"stringByAppendingString:_scExpectAmount]stringByAppendingString:@"元"];
}
-(NSString*)scActuaAmount{
    
    
    return [[@"结算佣金: "stringByAppendingString:_scActuaAmount]stringByAppendingString:@"元"];
}
-(UIColor*)scStateColor{
    
    if ([_scState isEqualToString:@"待结算"]) {
        return [UIColor cmThemeOrange];
    } else {
        return [UIColor clmHex:0x2f9831];
    }
}

-(NSString *) timeChange:(NSString *)timeString

{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    
    NSDate *currentDate = [dateFormatter dateFromString:timeString];
    
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
    
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *timeChanged = [outputFormatter stringFromDate:currentDate];
    

    
    return timeChanged;
    
}
@end
