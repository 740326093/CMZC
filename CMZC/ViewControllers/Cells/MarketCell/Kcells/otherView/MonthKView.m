//
//  MonthKView.m
//  MYLStockDemo
//
//  Created by WangWei on 2018/8/18.
//  Copyright © 2018年 myl. All rights reserved.
//

#import "MonthKView.h"
#import <AFNetworking.h>
#import "KLineChartView.h"
#import "KLineListTransformer.h"
@interface MonthKView ()

@property (nonatomic, strong) KLineListTransformer *lineListTransformer;
@property (nonatomic, strong) KLineChartView       *kLineChartView;


@end
@implementation MonthKView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        _kLineChartView = [[KLineChartView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width-10,self.frame.size.height-10)];
        _kLineChartView.backgroundColor = [UIColor clmHex:0x1E1E1E];
        _kLineChartView.topMargin = 10.0f;
        _kLineChartView.rightMargin = 1.0;
        _kLineChartView.bottomMargin = self.frame.size.height/3.0;
        _kLineChartView.kLineWidth = 2;
        _kLineChartView.showRSIChart = NO;
        _kLineChartView.showBarChart = YES;
        _kLineChartView.showAvgLine=NO;
        //是否支持手势  只有横屏才会支持
        _kLineChartView.supportGesture = YES;
        _kLineChartView.scrollEnable = YES;
        _kLineChartView.zoomEnable = YES;
        
        
        [self addSubview:self.kLineChartView];
        
        
    }
    
    return self;
}

-(void)requestDataWithUrl:(NSString*)url{
    [CMRequestAPI cm_marketFetchProductKlineDayCode:@"" productUrl:url success:^(NSArray *klineDayArr) {
        // MyLog(@"K值+++%@",klineDayArr);
        if(klineDayArr.count>0){
            NSMutableArray *bigArr=[NSMutableArray arrayWithCapacity:0];
            for (NSString *line in klineDayArr) {
                NSMutableDictionary *dataDict=[NSMutableDictionary dictionary];
                NSArray *newLitterArr= [line componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
                
                NSString *timeStr=newLitterArr[0];
                [dataDict setValue:[timeStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"] forKey:@"time"];
                [dataDict setValue:newLitterArr[1] forKey:@"open"];
                [dataDict setValue:newLitterArr[2] forKey:@"max"];
                [dataDict setValue:newLitterArr[3] forKey:@"min"];
                [dataDict setValue:newLitterArr[4] forKey:@"close"];
                [dataDict setValue:newLitterArr[5] forKey:@"volumn"];
                
                [bigArr addObject:dataDict];
            }
            MyLog(@"月K______%@",bigArr);
            NSDictionary *dic =   [[KLineListTransformer sharedInstance] managerTransformData:[bigArr copy]];
            [_kLineChartView drawChartWithData:dic];
            
            
        }
    } fail:^(NSError *error) {
        MyLog(@"请求日k失败了");
    }];
    
    
}

-(void)setCode:(NSString *)code{
    
  [self requestDataWithUrl:CMStringWithPickFormat(kMProductKlineMonthURL, code)];
    
}
@end
