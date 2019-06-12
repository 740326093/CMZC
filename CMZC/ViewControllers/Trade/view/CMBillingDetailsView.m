//
//  CMBillingDetailsView.m
//  CMZC
//
//  Created by 云财富 on 2019/5/29.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMBillingDetailsView.h"
#import "CMBillingCell.h"
#import "CMErrorView.h"
#import "CMBillingModel.h"
@interface CMBillingDetailsView ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *curTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) CMErrorView *errorView;
@end
@implementation CMBillingDetailsView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    
        [self initialization];
    }
    return self;
}
//-(void)awakeFromNib{
//    [super awakeFromNib];
//    [self initialization];
//}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}
-(void)initialization{
    
    [self addSubview:self.curTableView];
    
    [self addRequestDataMeans];
}
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    //显示菊花
    
  
    //添加下拉刷新
      __weak typeof(self) weakSelf = self;
    [self.curTableView addHeaderWithFinishBlock:^{
        if ([weakSelf.delegate respondsToSelector:@selector(refreshData)]) {
            [weakSelf.delegate refreshData];
        }
    }];
  
    
    
}
-(void)setBillingArray:(NSMutableArray *)billingArray{
    if ([self.curTableView.mj_header isRefreshing]) {
        [self.curTableView.mj_header endRefreshing];
    }
    
    [self.dataArray removeAllObjects];
    
    for (NSDictionary *recordDict in billingArray) {
        
        [self.dataArray addObject:[CMBillingModel yy_modelWithDictionary:recordDict]];
    }
    
    if (self.dataArray.count>0) {
        self.curTableView.hidden=NO;
        if (self.errorView) {
            [self.errorView removeView];
        }
    } else {
        self.curTableView.hidden = YES;
        [self addSubview:self.errorView];
    }
    
    [self.curTableView reloadData];
    
    
}
#pragma mark lazy
-(UITableView*)curTableView{
    if (!_curTableView) {
        _curTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), self.bounds.size.height) style:UITableViewStylePlain];
        _curTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        _curTableView.delegate=self;
        _curTableView.dataSource=self;
        _curTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), 50)];
    }
    return _curTableView;
}
-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
- (CMErrorView *)errorView {
    if (!_errorView) {
        
        _errorView = [[CMErrorView alloc] initWithFrame:self.bounds bgImageName:@"noList_image" titleName:@"暂无记录"];
        _errorView.backgroundColor=[UIColor whiteColor];
    }
    return _errorView;
}
#pragma mark Dealgate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID=@"CMBillingCell";

    CMBillingCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"CMBillingCell" owner:nil options:nil].firstObject;
        
    }
    cell.BillingMode=self.dataArray[indexPath.row];
    return cell;

}

@end
