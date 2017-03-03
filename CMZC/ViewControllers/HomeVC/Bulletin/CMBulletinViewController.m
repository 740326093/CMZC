//
//  CMBulletinViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMBulletinViewController.h"

@interface CMBulletinViewController ()<TitleViewDelegate,CMNewShiViewDelegate,CMNoticeViewDeleagte,CMMediaNewsViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *curScrollView;
@property (weak, nonatomic) IBOutlet CMMediaNewsView *mediaView;//媒体报道
@property (weak, nonatomic) IBOutlet CMNoticeView *noticeView;//公告
@property (weak, nonatomic) IBOutlet TitleView *contTitleView; //标题

@property (weak, nonatomic) IBOutlet CMNewShiView *ShiView; //新视点

@end

@implementation CMBulletinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _curScrollView.scrollEnabled = NO;
    _mediaView.delegate = self;
    _noticeView.delegate = self;
    _ShiView.delegate = self;
    
    _curScrollView.contentSize=CGSizeMake(3*CMScreen_width(), 553);
    _titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, 40)];
    [_contTitleView addSubview:_titleView];
    [self loadTitleView];
    [self clickTitleViewAtIndex:self.selectIndex];
}


#pragma mark - TitleViewDelegate 
- (void)clickTitleViewAtIndex:(NSInteger)index andTab:(UIButton *)tab {
  
    CGRect rect = CGRectMake(index *CGRectGetWidth(_curScrollView.frame), 0, CGRectGetWidth(_curScrollView.frame), CGRectGetHeight(_curScrollView.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [_curScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
    }];
    
    
}
- (void)clickTitleViewAtIndex:(NSInteger)index{
    
    self.titleView.selectBtnIndex=index;
    CGRect rect = CGRectMake(index *CGRectGetWidth(_curScrollView.frame), 0, CGRectGetWidth(_curScrollView.frame), CGRectGetHeight(_curScrollView.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [_curScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
    }];
}

#pragma makr - CMNoticeViewDeleagte && CMMediaNewsViewDelegate
//媒体报道
- (void)cm_mediaNewsViewSendWebURL:(NSString *)webURL {
    [self pushWebViewVCURL:webURL];
}
//公告
- (void)cm_noticeViewSendNoticeModel:(CMNewShiModel *)notice {

    NSString *webUrl = CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"/Account/MessageDetail?nid=%ld",(long)notice.mediaId]);
    ;
    [self pushWebViewVCURL:webUrl];
}
//新视点
- (void)cm_NewShiSendModel:(CMNewShiModel *)notice{
    
    NSString *webUrl = CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"/Account/MessageDetail?nid=%ld",(long)notice.mediaId]);
    ;
    [self pushWebViewVCURL:webUrl];
}

- (void)pushWebViewVCURL:(NSString *)webUrl {
    CMCommWebViewController *commWebVC = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
    commWebVC.urlStr = webUrl;
    [self.navigationController pushViewController:commWebVC animated:YES];
}


#pragma mark - getSter 
- (void)loadTitleView {
    //媒体报道
    UIButton *sortNewButton = [UIButton cm_customBtnTitle:@"媒体报道"];
    //新视点
     UIButton *sortNewShiButton = [UIButton cm_customBtnTitle:@"新观点"];
    
    //公告
    UIButton *sortHotButton = [UIButton cm_customBtnTitle:@"公告"];
   // self.titleView.selectBtnIndex=self.selectIndex;
    [self.titleView addTabWithoutSeparator:sortNewButton];
    [self.titleView addTabWithoutSeparator:sortNewShiButton];

    [self.titleView addTabWithoutSeparator:sortHotButton];
 
    self.titleView.delegate = self;
    
    
}


#pragma mark -
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
