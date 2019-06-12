//
//  CMMyInviteController.m
//  CMZC
//
//  Created by 云财富 on 2019/5/28.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMMyInviteController.h"
#import "CMCentCommissionDetailView.h"
#import "CMBillingDetailsView.h"
#import "CMShareView.h"
#import "CMCentIntroductView.h"
@interface CMMyInviteController ()<CMSwitchViewDelegate,CMCentCommissionDetailViewDelegate,CMBillingDetailsViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *totalIncomLab;
@property (weak, nonatomic) IBOutlet UILabel *lastMonthLab;
@property (weak, nonatomic) IBOutlet UILabel *currentMonthLab;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;
@property (weak, nonatomic) IBOutlet CMSwitchView *switchView;
@property (strong, nonatomic) CMShareView *shareView;

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (strong, nonatomic) CMCentCommissionDetailView *centview;
@property (strong, nonatomic) CMBillingDetailsView *billview;
@property (copy, nonatomic) NSString *inviteUrl;
@end

@implementation CMMyInviteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _bottomScrollView.contentSize=CGSizeMake(2*CMScreen_width(),_bottomScrollView.bounds.size.height);
    _switchView.delegate=self;
    
 
}
-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    [_leftView addSubview:self.centview];
    [_rightView addSubview:self.billview];
    
    [self LoadRecordData];
    
   
   
}



-(CMCentCommissionDetailView*)centview{
    if (!_centview) {
      _centview=[[CMCentCommissionDetailView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), _bottomScrollView.bounds.size.height)];
        _centview.delegate=self;

    }
    return _centview;
}
-(CMBillingDetailsView*)billview{
    if (!_billview) {
         _billview=[[CMBillingDetailsView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), _bottomScrollView.bounds.size.height)];
        _billview.delegate=self;
    }
    return _billview;
}

-(void)refreshData{
    [self LoadRecordData];
}
#pragma mark 立即邀请

- (IBAction)shareInvitionEvent:(id)sender {
    //MyLog(@"邀请");
    if (_inviteUrl.length>0) {
    
    CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
    webVC.urlStr = _inviteUrl;
    webVC.showRefresh=NO;
    [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (IBAction)invitonIntroductEvent:(id)sender {
    
    CMCentIntroductView *alertView=[CMCentIntroductView initByNibForClassName];
    alertView.frame=CGRectMake(0, 0, CMScreen_width(), CMScreen_height());
    [self.view.window addSubview:alertView];
    
    
    
}
-(void)selectOffsetWithIndex:(NSInteger)offset{
    
    CGRect rect = CGRectMake(offset *CGRectGetWidth(_bottomScrollView.frame), 0, CGRectGetWidth(_bottomScrollView.frame), CGRectGetHeight(_bottomScrollView.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [_bottomScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
    }];
    
    
}
-(CMShareView*)shareView{
    if (!_shareView) {
         _shareView=[[CMShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height())];
    }
    
    return _shareView;
}

-(void)LoadRecordData{
    
    [CMRequestAPI cm_applyRequestInvationRecordSuccess:^(NSDictionary *recordDict) {
        
        MyLog(@"请求记录+++%@",recordDict);
        NSDictionary *record=recordDict[@"data"];
        _totalIncomLab.text=[NSString stringWithFormat:@"%@",record[@"mscTotalSettle"]];
        _lastMonthLab.text=[NSString stringWithFormat:@"%@",record[@"mscLastMouth"]];
        _currentMonthLab.text=[NSString stringWithFormat:@"%@",record[@"mscThisMouth"]];
        
      self.centview.centComissionArray=[NSMutableArray arrayWithArray:recordDict[@"data"][@"mscStatisticsList"]];
        self.billview.billingArray=[NSMutableArray arrayWithArray:recordDict[@"data"][@"mscStatisticsSettleList"]];
        _inviteUrl=[NSString stringWithFormat:@"%@%@",kCMMZWeb_url,record[@"mscInviteUrl"]];
        
    } fail:^(NSError *error) {
        
    }];
    
    
    
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
