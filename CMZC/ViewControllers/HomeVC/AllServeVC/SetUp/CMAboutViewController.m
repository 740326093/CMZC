//
//  CMAboutViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMAboutViewController.h"
#import "CMAboutFootView.h"
#import "CMAboutSecondCell.h"
#import "CMAboutFirstCell.h"
#import "CMAboutHeadView.h"
@interface CMAboutViewController ()<UITableViewDataSource,UITableViewDelegate>
//@property (weak, nonatomic) IBOutlet UILabel *VersionNumLabel;
//@property (weak, nonatomic) IBOutlet UILabel *servicePhoneNum;
@property(nonatomic,strong)UITableView *curTableView;
@end

@implementation CMAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于";
    [self.view addSubview:self.curTableView];
//    _VersionNumLabel.text=[NSString stringWithFormat:@"版本号:V%@", [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
   

}
-(UITableView*)curTableView{
    if (!_curTableView) {
        _curTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _curTableView.delegate=self;
        _curTableView.dataSource=self;
        _curTableView.tableFooterView=[CMAboutFootView initByNibForClassName];
        _curTableView.tableHeaderView=[CMAboutHeadView  initByNibForClassName];
        _curTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _curTableView.showsVerticalScrollIndicator=NO;
        _curTableView.showsHorizontalScrollIndicator=NO;
    }
    return _curTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0.01f;
    }else{
        return 10.0f;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        CMAboutFirstCell *FirstCell=[tableView dequeueReusableCellWithIdentifier:@"CMAboutFirstCell"];
        if (!FirstCell) {
            FirstCell = [[NSBundle mainBundle] loadNibNamed:@"CMAboutFirstCell" owner:nil options:nil].firstObject;
        }
        return FirstCell;
    }else{
        CMAboutSecondCell *SecondCell=[tableView dequeueReusableCellWithIdentifier:@"CMAboutSecondCell"];
        if (!SecondCell) {
           SecondCell = [[NSBundle mainBundle] loadNibNamed:@"CMAboutSecondCell" owner:nil options:nil].firstObject;
        }
        return SecondCell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 180;
    }else{
        return 150.f;
    }
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
