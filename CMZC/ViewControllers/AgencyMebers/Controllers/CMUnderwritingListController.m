//
//  CMUnderwritingListController.m
//  CMZC
//
//  Created by WangWei on 2018/2/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMUnderwritingListController.h"
#import "TitleView.h"
#import "CMHotApplyListView.h"
#import "CMMyApplyListView.h"
@interface CMUnderwritingListController ()<TitleViewDelegate>

@property (weak, nonatomic) IBOutlet TitleView *curTitle;
@property (weak, nonatomic) IBOutlet UIScrollView *curScrollView;


@end

@implementation CMUnderwritingListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _curScrollView.contentSize=CGSizeMake(2*CMScreen_width(), CGRectGetHeight(_curScrollView.frame));
    _curScrollView.scrollEnabled=NO;
    _curScrollView.backgroundColor=[UIColor clmHex:0xefeff4];
    [self loadTitleView];
    
    CMMyApplyListView *applyListView=[CMMyApplyListView initByNibForClassName];
    applyListView.ListController=self;
    applyListView.frame=CGRectMake(0, 0, CMScreen_width(), CGRectGetHeight(_curScrollView.frame));
    [_curScrollView  addSubview:applyListView];
    CMHotApplyListView *HotApplyList=[CMHotApplyListView initByNibForClassName];
    HotApplyList.UnderwritingListController=self;
    HotApplyList.frame=CGRectMake(CMScreen_width(), 0, CMScreen_width(), CGRectGetHeight(_curScrollView.frame));
    [_curScrollView  addSubview:HotApplyList];
    
}

#pragma mark - getSter
- (void)loadTitleView {
 
    //UIButton *sortNewButton = [UIButton cm_customBtnTitle:@"我承销的项目"];
    
    UIButton *sortNewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sortNewButton setTitle:@"我承销的项目" forState:UIControlStateNormal];
    sortNewButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [sortNewButton setTitleColor:[UIColor cmTacitlyFontColor] forState:UIControlStateNormal];
    [sortNewButton setTitleColor:[UIColor cmThemeOrange] forState:UIControlStateSelected];

    UIButton *sortHotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sortHotButton setTitle:@"其他热门承销项目" forState:UIControlStateNormal];
    sortHotButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [sortHotButton setTitleColor:[UIColor cmTacitlyFontColor] forState:UIControlStateNormal];
    [sortHotButton setTitleColor:[UIColor cmThemeOrange] forState:UIControlStateSelected];
   // UIButton *sortHotButton = [UIButton cm_customBtnTitle:@"其他热门承销项目"];
    [_curTitle addTabWithoutSeparator:sortNewButton];
   
    
    [_curTitle addTabWithoutSeparator:sortHotButton];
    
    _curTitle.delegate = self;
    
    
}

- (void)clickTitleViewAtIndex:(NSInteger)index andTab:(UIButton *)tab{
    
    CGRect rect = CGRectMake(index *CMScreen_width(), 0, CGRectGetWidth(_curScrollView.frame), CGRectGetHeight(_curScrollView.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [_curScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
