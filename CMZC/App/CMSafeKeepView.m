//
//  CMSafeKeepView.m
//  CMZC
//
//  Created by WangWei on 17/3/3.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMSafeKeepView.h"
#import "CMSafeIconView.h"
@interface CMSafeKeepView ()

@end


@implementation CMSafeKeepView


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {

        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 15)];
        title.text=@"安全保障";
        title.font=[UIFont systemFontOfSize:14.0];
        title.textColor=[UIColor clmHex:0x333333];
        [self addSubview:title];
        UILabel *title1=[[UILabel alloc]initWithFrame:CGRectMake(70, 12, 180, 13)];
        title1.text=@"多重安全机制确保100%安全";
        title1.font=[UIFont systemFontOfSize:12.0];
        title1.textColor=[UIColor clmHex:0x333333];
        [self addSubview:title1];
        
        NSArray *imageArr=@[@"add_img1-02",@"add_img1-03",@"add_img1-04",@"add_img1-05"];
        
        NSArray *titileArr=@[@"资金银行托管安全",@"风控安全",@"项目安全",@"机构保障安全"];
        
        NSArray *detailArr=@[@"银行监管资金安全,专款专户专用",@"业内著名专家领衔,执行当今最安全的7级风险管控体系",@"严格筛选新经济行业高成长企业,优选新经济/新模式/新产业项目",@"机构均为行业顶尖企业，全程监管项目审批、运营专业管理人以劣后资金参与领投,优先保证投资者本金安全"];
        
        for (int i=0; i<imageArr.count; i++) {
            //列号
            int col =i%2;
            //行号
            int row =i/2;
            float x = col*(CMScreen_width()/2.0);
            float y =50+row*(180);
            CMSafeIconView *iconView=[[CMSafeIconView alloc]init];
            iconView.frame=CGRectMake(x, y, CMScreen_width()/2.0, 180);
            iconView.topImageView.image=[UIImage imageNamed:imageArr[i]];
            iconView.midLabel.text=titileArr[i];
            iconView.bottomLabel.text=detailArr[i];
            [self addSubview:iconView];
            CGRect rect=[ detailArr[i] boundingRectWithSize:CGSizeMake(CMScreen_width()-20, 60) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} context:nil];
            [iconView.bottomLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(rect.size.height+20);
            }];
            if (i==0) {
                CGRect rect=[ detailArr[i] boundingRectWithSize:CGSizeMake(CMScreen_width()-20, 60) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} context:nil];
                [iconView.bottomLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(rect.size.height+10);
                }];
            }
            
        }
        
        
        
        
    }
    return self;
}

@end