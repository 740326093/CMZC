//
//  CMAppUpdate.m
//  CMZC
//
//  Created by 云财富 on 2019/7/4.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMAppUpdate.h"

@implementation CMAppUpdate
-(instancetype)init{
    self=[super init];
    if (self) {
        
        
        [self  requestServiceVersion];
    }
    return self;
    
    
}

-(void)requestServiceVersion{
    
    [CMRequestAPI cm_appVersionSuccess:^(CMVersionModel *VersionModel) {
        
       
    [self compareVersion:VersionModel];
            
            
       
        
        
    } fail:^(NSError *error) {
        
        
        
        
    }];
    
}
#pragma mark  判断版本大小
- (void)compareVersion:(CMVersionModel*)sender {
    
   //sender.updateStatus=NO;
   
    //获取APP自身版本号
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSArray *localArray = [localVersion componentsSeparatedByString:@"."];
    
    //获取数据版本号
    NSArray *versionArray = [sender.number componentsSeparatedByString:@"."];
    
    //比较
    NSUInteger count = versionArray.count;
    if (versionArray.count > localArray.count) {
        count = localArray.count;
    }
    
    if (versionArray.count<=0) {
        return;
    }

    for (int i = 0; i < count; i++) {
        if ([localArray[i] intValue] <[versionArray[i] intValue]) {
            NSLog (@"需要更新");
//            if (sender.updateStatus) {
//                [self showAPPUpdateAlert:sender];
//            } else {
//                if( [self allowShowLocationAlert]){
//
//                 [self showAPPUpdateAlert:sender];
//                }
//            }
            
            [self showAPPUpdateAlert:sender];
            return;
        }
        //审核时本地大于线上,开发时也有可能
        if ([localArray[i] intValue] >[versionArray[i] intValue]) {
           NSLog (@"本地版本大于等于线上,无需更新");
            return;
        }
    }
    //出现了1.2和1.2.3的情况,肯定是长的那个是高版本,因为不存在1.2和1.2.0对比的情况
    if (versionArray.count < localArray.count) {
        
//        if (sender.updateStatus) {
//            [self showAPPUpdateAlert:sender];
//        } else {
//            if( [self allowShowLocationAlert]){
//
//                [self showAPPUpdateAlert:sender];
//            }
//        }
         [self showAPPUpdateAlert:sender];
         NSLog (@"需要更新");
        
        return;
    }
    

   
}

-(void)showAPPUpdateAlert:(CMVersionModel*)VersionModel {
   
    
    
    if ([self.updateDelegate respondsToSelector:@selector(isMustUpdateAPPVersion:)]) {
        [self.updateDelegate isMustUpdateAPPVersion:VersionModel];
    }
    
  
    
}


/**
 *   是否允许弹窗
 */
-(BOOL)allowShowLocationAlert{
    
    NSDate *now = [NSDate date];
    //当前时间的时间戳
    NSTimeInterval nowStamp = [now timeIntervalSince1970];
    //当天零点的时间戳
    NSTimeInterval zeroStamp = [[[NSUserDefaults standardUserDefaults] objectForKey:@"zeroStamp"] doubleValue];
    //一天的时间戳
    NSTimeInterval oneDay = 60* 60 * 24;
    
    /**
     "showedLocation"代表了是否当天是否提醒过开启定位，NO代表没有提醒过，YES代表已经提醒过
     */
    
    if(nowStamp - zeroStamp> oneDay){
        
        zeroStamp = [self getTodayZeroStampWithDate:now];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:zeroStamp] forKey:@"zeroStamp"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"showedLocation"];
        return YES;
        
    }else{
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"showedLocation"]) {
            return NO;
            
        }else{
            return YES;
        }
        
    }
    
}

/**
 * 获取当天零点时间戳
 */
- (double)getTodayZeroStampWithDate:(NSDate *)date{
    
    NSDateFormatter *dateFomater = [[NSDateFormatter alloc]init];
    dateFomater.dateFormat = @"yyyy年MM月dd日";
    NSString *original = [dateFomater stringFromDate:date];
    NSDate *ZeroDate = [dateFomater dateFromString:original];
    // 今天零点的时间戳
    NSTimeInterval zeroStamp = [ZeroDate timeIntervalSince1970];
    return zeroStamp;
    
}
@end
