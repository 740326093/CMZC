//
//  CMInquireCollectionViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMInquireCollectionViewCell.h"

#import "CMTradeSearchCell.h"


@interface CMInquireCollectionViewCell ()<UITableViewDataSource,UITableViewDelegate> {
    NSArray *_tableTitleArr;
}
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@end


@implementation CMInquireCollectionViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
    _tableTitleArr = @[@[@"资产",@"成交查询",@"委托查询"],@[@"新品申购查询",@"中签查询",@"申购记录查询",@"我的倍利宝",@"申购指南"]];
    _curTableView.delegate = self;
    _curTableView.dataSource = self;
    _curTableView.tableFooterView = [[UIView alloc] init];
    
}

#pragma mark - UITableViewDataSource &&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tableTitleArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMTradeSearchCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"CMTradeSearchCell"];
    if (!tableCell) {
        tableCell = [[NSBundle mainBundle]loadNibNamed:@"CMTradeSearchCell" owner:nil options:nil].firstObject;
       
    
    }
 
    tableCell.nameLab.text = _tableTitleArr[indexPath.section][indexPath.row];
 

    return tableCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), 10)];
    headerView.backgroundColor = [UIColor cmDividerColor];
    return headerView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(cm_inquireCollectionIndexPath:)]) {
        [self.delegate cm_inquireCollectionIndexPath:indexPath];
    }
    
    
   
    
}

@end


























