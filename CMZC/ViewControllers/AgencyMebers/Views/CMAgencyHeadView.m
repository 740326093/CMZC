//
//  CMAgencyHeadView.m
//  CMZC
//
//  Created by WangWei on 2018/1/31.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMAgencyHeadView.h"
#import "CMIssuerView.h"
#import "CMComponentView.h"
#import "CMSponsorView.h"
@interface CMAgencyHeadView ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *selectSengenmt;
@property (weak, nonatomic) IBOutlet UIScrollView *curScrollerView;
@property (weak, nonatomic) IBOutlet UIView *bottomBackView;

@end
@implementation CMAgencyHeadView

-(void)awakeFromNib{
    [super awakeFromNib];
   
    //默认选择索引
    [_selectSengenmt setSelectedSegmentIndex:0];
    //设置选中颜色
    [_selectSengenmt setTintColor:[UIColor clmHex:0xF14C0A]];
    // 设置选中的文字颜色
    [_selectSengenmt setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
    [_selectSengenmt setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clmHex:0xF14C0A]} forState:UIControlStateNormal];
    [_selectSengenmt addTarget:self action:@selector(SwitchClickEvent:) forControlEvents:UIControlEventValueChanged];
    _curScrollerView.contentSize=CGSizeMake(CMScreen_width()*3, CGRectGetHeight(_bottomBackView.frame));
    
    CMIssuerView *IssuerView=[CMIssuerView initByNibForClassName];
    IssuerView.frame=CGRectMake(0, 0, CMScreen_width(), CGRectGetHeight(_bottomBackView.frame));
    [_curScrollerView addSubview:IssuerView];
    CMComponentView *ComponentView=[CMComponentView initByNibForClassName];
    ComponentView.frame=CGRectMake(CMScreen_width(), 0, CMScreen_width(), CGRectGetHeight(_bottomBackView.frame));
    [_curScrollerView addSubview:ComponentView];
    CMSponsorView *SponsorView=[CMSponsorView initByNibForClassName];
    SponsorView.frame=CGRectMake(CMScreen_width()*2, 0, CMScreen_width(), CGRectGetHeight(_bottomBackView.frame));
    [_curScrollerView addSubview:SponsorView];
   
}


- (void)SwitchClickEvent:(UISegmentedControl *)sender {

    
  
    if ([self.delegate respondsToSelector:@selector(selectItemIndex:)]) {
        [self.delegate selectItemIndex:sender.selectedSegmentIndex];
    }

    if (sender.selectedSegmentIndex==1) {
        self.frame=CGRectMake(0, 0, CMScreen_width(), 320);
       
      _bottomBackView.bounds=CGRectMake(0, 0, CMScreen_width(), 260);
   

    }else{
       
        self.frame=CGRectMake(0, 0, CMScreen_width(), 260);
       _bottomBackView.bounds=CGRectMake(0, 0, CMScreen_width(), 190);
    
    }
    
      [_curScrollerView setContentOffset:CGPointMake(CMScreen_width()*sender.selectedSegmentIndex, 0) animated:NO];
    
}

@end
