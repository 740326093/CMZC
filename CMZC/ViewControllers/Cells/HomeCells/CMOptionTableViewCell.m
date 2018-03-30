//
//  CMOptionTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMOptionTableViewCell.h"
#import "CMOptionCollectionViewCell.h"
#import "CMNewActionHeadView.h"
@interface CMOptionTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;//注册
@property (weak, nonatomic) IBOutlet UIButton *optionalBtn; //自选
@property (weak, nonatomic) IBOutlet UIButton *analystBtn; //分析师
@property (weak, nonatomic) IBOutlet UIButton *noticeBtn; //公告
@property (weak, nonatomic) IBOutlet UIButton *raiseMoneyBtn; //众筹宝
@property (weak, nonatomic) IBOutlet UIButton *moreBtn; //更多

@property (weak, nonatomic) IBOutlet UICollectionView *curCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionflowLayout;

@property (strong, nonatomic) NSArray *titImageArr; //图片名字
@property (strong, nonatomic) NSArray *titLabNameArr;  //介绍名字

@end


@implementation CMOptionTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
     
   //注册
    _collectionflowLayout.itemSize = CGSizeMake(CMScreen_width()/3.0, 100);
    _curCollectionView.delegate = self;
    _curCollectionView.dataSource = self;
    [_curCollectionView registerClass:[CMNewActionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CMServeReusableView"];
    

    [self requestTrends];
}
#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMOptionCollectionViewCell *optionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CMOptionCollectionViewCell" forIndexPath:indexPath];
    [optionCell cm_optionCollectionCellTitleImageName:self.titImageArr[indexPath.row]
                                           nameLabStr:self.titLabNameArr[indexPath.row]];
    return optionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(cm_optionTableViewCellButTag:)]) {
        [self.delegate cm_optionTableViewCellButTag:indexPath.row];
    }
    
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind==UICollectionElementKindSectionHeader) {
      CMNewActionHeadView  *serveView = (CMNewActionHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CMServeReusableView" forIndexPath:indexPath];
        serveView.delegate=self;
        serveView.titleArr=self.gongGaoArr;
        return serveView;
    }else{
        return nil;
    }
    
}
#pragma mark 公告更多
-(void)MoreButtonClick{
  
    CMBulletinViewController *bulletin = (CMBulletinViewController *)[CMBulletinViewController initByStoryboard];
    bulletin.selectIndex=2;
    [self.baseController.navigationController pushViewController:bulletin animated:YES];
}
#pragma mark 公告详情
-(void)clickNewActionDetail:(NSInteger)index{
    

    CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
    
    CMNewShiModel*model=self.gongGaoArr[index];
    MyLog(@"最新公告详情+++%ld_______%ld",model.mediaId,index);
    NSString *strUrl = CMStringWithPickFormat(kCMMZWeb_url,[NSString stringWithFormat:@"/Account/MessageDetail?nid=%ld",(long)model.mediaId])
    ;
    webVC.urlStr =strUrl;
    webVC.showRefresh=YES;
    [self.baseController.navigationController pushViewController:webVC animated:YES];
    
}


-(NSMutableArray*)gongGaoArr{
    if (!_gongGaoArr) {
        _gongGaoArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _gongGaoArr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)leapTransferButClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cm_optionTableViewCellButTag:)]) {
        [self.delegate cm_optionTableViewCellButTag:sender.tag];
    }
}



- (void)requestTrends {
    
    
    [CMRequestAPI cm_trendsNewDataPage:1 withType:@"8" success:^(NSArray *dataArr, BOOL isPage) {
        
        [self.gongGaoArr removeAllObjects];
        [self.gongGaoArr addObjectsFromArray:dataArr];
        
        if (self.gongGaoArr.count>0) {
   [_collectionflowLayout setHeaderReferenceSize:CGSizeMake(CMScreen_width(), 30)];
            [self.curCollectionView reloadData];
        }
        
    } fail:^(NSError *error) {
        MyLog(@"最新动态请求失败");
    }];
}



#pragma mark - set get
- (NSArray *)titImageArr {
    return @[@"deal_home",
             @"invest_home",
             @"security_home",
             @"many_home",
             @"register_home",
             @"more_home"];
}
//- (NSArray *)titLabNameArr {
//    return @[ CMIsLogin()?@"我的账户":@"注册/登录",
//             @"自选",
//             @"分析师",
//             @"公告",
//             @"倍利宝",
//             @"更多"];
//}
- (NSArray *)titLabNameArr {
    return @[ @"交易指南",
              @"投资讲堂",
              @"安全保障",
              @"倍利宝",
              CMIsLogin()?@"我的账户":@"开户",
              @"更多"];
}
@end
