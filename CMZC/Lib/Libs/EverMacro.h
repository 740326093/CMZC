//
//  EverMacro.h
//  FenShiChart
//
//  Created by Ever on 15/12/30.
//  Copyright © 2015年 Ever. All rights reserved.
//

#ifndef EverMacro_h
#define EverMacro_h


#define kBorderColor [UIColor cmMarketDivider]       //图表边框颜色
//#define kDashColor [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0              alpha:1] //图表虚线颜色

#define kDashColor [UIColor cmMarketDivider]
#define kYFontColor [UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0                   alpha:1]       //X轴刻度文字颜色

#define KYFontName                                                                             @"Helvetica"   //Y轴刻度文字字体
#define kYFontSizeFenShi                                                                       (10)           //Y轴刻度文字大小
#define kFenShiVolumeYFontColor [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1]       //成交量图：Y轴刻度文字颜色
#define kBtnBgColor [UIColor colorWithRed:51 green:51 blue:51             alpha:1]       //Y 轴中 btn 背景色

#define kFenShiAvgColor [UIColor colorWithRed:144/255.0 green:169/255.0 blue:15/255.0          alpha:1]       //均线颜色
#define kFenShiNowColor [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0               alpha:1]       //实线颜色

#define kFenShiUpColor [UIColor colorWithRed:252/255.0 green:15/255.0 blue:29/255.0            alpha:1]       //成交量上涨颜色
#define kFenShiDownColor [UIColor colorWithRed:22/255.0 green:151/255.0 blue:25/255.0          alpha:1]       //成交量下跌颜色
#define kFenShiEqualColor [UIColor colorWithRed:183/255.0 green:183/255.0 blue:183/255.0       alpha:1]       //成交量持平颜色

#define kFenShiLine                                                                            @"fenShiLine"  //线段图类型标记
#define kFenShiColumn                                                                          @"fenShiColumn"//成交量图类型标记

#define kFenShiNowNameLine                                                                     @"nowLine"     //分时图实时线名称标记
#define kFenShiAvgNameLine                                                                     @"avgLine"     //分时图均线名称标记
#define kFenShiVolNameColumn                                                                      @"column"      //分时图成交量名称标记

#endif /* EverMacro_h */
