//
//  CMMyCollectController.m
//  CMZC
//
//  Created by WangWei on 2017/4/14.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMMyCollectController.h"
#import "CMCollectCell.h"
#import "CMPurchaseProduct.h"
#import "CMNoCollectView.h"
@interface CMMyCollectController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTablView;
@property(nonatomic,strong) NSMutableArray *productDataArr;
@property(nonatomic,strong) CMNoCollectView *NoCollectView;
@end

@implementation CMMyCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addRequestDataMeans];
    
    self.NoCollectView.imageName=@"no_data";
    self.NoCollectView.bottomLab.text=@"亲,暂时还没有收藏记录哦!";
    [self.view addSubview:self.NoCollectView];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancleCollectOrCollect) name:@"cancleCollectOrCollect" object:nil];
}
-(void)cancleCollectOrCollect{
    [self addRequestDataMeans];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
-(NSMutableArray*)productDataArr{
    if (!_productDataArr) {
        _productDataArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _productDataArr;
}
-(CMNoCollectView*)NoCollectView{
    if(!_NoCollectView){
        _NoCollectView=[[CMNoCollectView alloc]initWithFrame:CGRectMake(0, 150, CMScreen_width(), CMScreen_height()-150)];
        _NoCollectView.hidden = YES;
    }
    return _NoCollectView;
}
#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    _curTablView.hidden = YES;
    
    [self requestListWithPageNo:1];
    //添加下拉刷新
    [_curTablView addHeaderWithFinishBlock:^{
        [self requestListWithPageNo:1];
    }];
    //添加上提加载
    [_curTablView addFooterWithFinishBlock:^{
        NSInteger page = _productDataArr.count / 10 + 1;
        [self requestListWithPageNo:page];
    }];
    
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    //刷新令牌
   
        [CMRequestAPI cm_applyFetchCollectProductListOnPageIndex:page pageSize:10 isCollect:1 success:^(NSArray *productArr, BOOL isPage) {
    
            [_curTablView endRefresh];//结束刷新
            
            //区分显示教view
            isPage ?[_curTablView resetNoMoreData]:[_curTablView noMoreData];
            if (page == 1) {
                [self.productDataArr removeAllObjects];
            }
            [self.productDataArr addObjectsFromArray:productArr];
            if (self.productDataArr.count>0) {
                _curTablView.hidden = NO;
                self.NoCollectView.hidden=YES;
            }else{
                 _curTablView.hidden = YES;
                self.NoCollectView.hidden=NO;
            }
            [_curTablView reloadData];
        } fail:^(NSError *error) {
            [self hiddenProgressHUD];
            [_curTablView endRefresh];
            [self showHUDWithMessage:error.message hiddenDelayTime:2];
        }];
        
  
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.productDataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10.0f;
    }else{
       return 0.01f;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     CMCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CMCollectCell" forIndexPath:indexPath];
 
    cell.product=self.productDataArr[indexPath.section];
    cell.index=indexPath;
    __weak typeof(self) weakSelf=self;
    cell.applyBtnClickBlock = ^(NSIndexPath *index) {
        MyLog(@"section+++%ld",index.section);
        CMPurchaseProduct * product=weakSelf.productDataArr[indexPath.section];
        CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
        webVC.urlStr = [NSString stringWithFormat:@"%@/Invest/Confirm?pid=%ld",kCMMZWeb_url,product.productId];
        [weakSelf.navigationController pushViewController:webVC animated:YES];
        
    };
  
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   
    CMPurchaseProduct *product = self.productDataArr[indexPath.section];
    CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
   webVC.ProductId=product.productId;
    webVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url,CMStringWithPickFormat(@"/Products/Detail?pid=",CMStringWithFormat(product.productId)));
    [self.navigationController pushViewController:webVC animated:YES];
   
}
@end
