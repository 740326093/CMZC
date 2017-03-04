//
//  CMTouCeView.m
//  CMZC
//
//  Created by WangWei on 17/3/3.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMTouCeView.h"
#import "CMButtonLabelView.h"
@implementation CMTouCeView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 15)];
        title.text=@"投资策略";
        title.font=[UIFont systemFontOfSize:17.0];
        title.textColor=[UIColor clmHex:0x111111];
        [self addSubview:title];
        UILabel *title1=[[UILabel alloc]initWithFrame:CGRectMake(90, 12, 180, 13)];
        title1.text=@"只投优选10倍股";
        title1.font=[UIFont systemFontOfSize:12.0];
        title1.textColor=[UIColor clmHex:0x666666];
        [self addSubview:title1];
        
       
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray *imageArr=@[@"zcb-details-cl-02",@"zcb-details-cl-03",@"zcb-details-cl-04",@"zcb-details-cl-05"];
            
            NSArray *titileArr=@[@"新三板",@"互联网+",@"新经济",@"典藏艺术"];
            
            for (int i=0; i<imageArr.count; i++) {
                
                CMButtonLabelView  *buttonLabel=[[CMButtonLabelView  alloc]initWithFrame:CGRectMake(i%imageArr.count*( CMScreen_width()/4.0), 50, CMScreen_width()/4.0,60)];
                buttonLabel.topImageView.image=[UIImage imageNamed:imageArr[i]];
                buttonLabel.bottomLabel.text=titileArr[i];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                [self addSubview:buttonLabel];
                 
                    
                });
              
            }
           
            
        });
      
        
        
        
     
    }
    return self;
}


@end
