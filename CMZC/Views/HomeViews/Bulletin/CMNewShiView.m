//
//  CMNewShiView.m
//  CMZC
//
//  Created by WangWei on 17/2/23.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMNewShiView.h"
#import "CMNewShiCell.h"
@interface CMNewShiView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *curTableView;


@property (strong, nonatomic) NSMutableArray *NewShiDataArr;

@end
@implementation CMNewShiView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        CMNewShiView *NewShi = [[NSBundle mainBundle] loadNibNamed:@"CMNewShiView" owner:self options:nil].firstObject;
        [self addSubview:NewShi];
        NewShi.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:NewShi];
        //_curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _curTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    }
    return self;
}
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)awakeFromNib {
    [self showHubTacit];
    [self addRequestDataMeans];
    
}


//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    //显示菊花
    _curTableView.hidden = YES;
    [self requestListWithPageNo:1];
    //添加下拉刷新
     __block CMNewShiView *weakSelf =self;
    [_curTableView addHeaderWithFinishBlock:^{
        [weakSelf requestListWithPageNo:1];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        NSInteger page = self.NewShiDataArr.count / 10 +1;
        [weakSelf requestListWithPageNo:page];
    }];
    
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    [CMRequestAPI cm_trendsNewDataPage:page withType:@"16" success:^(NSArray *dataArr,BOOL isPage) {
        
        MyLog(@"page+++++%ld++%d",page,isPage);
        [self hideHubTacit];
        [_curTableView endRefresh];
        kCurTableView_foot//根据返回回来的数据，判断footview的区别
        if (page == 1) {
            
            [self.NewShiDataArr removeAllObjects];
        }
        if (dataArr.count >0) {
            //结束刷新
            _curTableView.hidden = NO;
        }
          
        [self.NewShiDataArr addObjectsFromArray:dataArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        [_curTableView endRefresh];
        [self showHubView:self messageStr:error.message time:2];
    }];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.NewShiDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMNewShiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CMMediaTableViewCell"];
    if (!cell) {
        cell = [CMNewShiCell initByNibForClassName];
    }
    
    //没数据先注销
  cell.ShiModel =self.NewShiDataArr[indexPath.row];
   // MyLog(@"新视点+++%@+++%ld",cell.ShiModel.link,cell.ShiModel.mediaId);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMNewShiModel *media = self.NewShiDataArr[indexPath.row];
    
     NSLog(@"..%@",media.link);
    //取出来webURL的链接
    if ([self.delegate respondsToSelector:@selector(cm_NewShiSendModel:)]) {
      [self.delegate cm_NewShiSendModel:media];//传入webURL
    }
    
}
#pragma mark - set get
- (NSMutableArray *)NewShiDataArr {
    if (!_NewShiDataArr) {
        _NewShiDataArr = [NSMutableArray array];
    }
    return _NewShiDataArr;
}


@end
