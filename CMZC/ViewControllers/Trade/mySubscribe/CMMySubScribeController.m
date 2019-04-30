//
//  CMMySubScribeController.m
//  CMZC
//
//  Created by WangWei on 2017/12/5.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMMySubScribeController.h"
#import "CMMySubCell.h"
#import"CMJackpotViewController.h"
#import "CMSubscribeGuideViewController.h"
@interface CMMySubScribeController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_titImageArr;//头图片Image
    NSArray *_titLabNameArr;//名字lab
}
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

@end

@implementation CMMySubScribeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的申购";
    
    _titLabNameArr = @[@[@"我的申购记录",@"中签查询",@"我的倍利宝"],@[@"新品申购",@"申购指南"]];
    _titImageArr =@[@[@"my_subRecord",@"CodesRecord",@"my_BlPr"],@[@"newPr_get",@"subhelp"]];
    
    self.tabBarController.tabBar.hidden=YES;
}


#pragma mark dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *rowArr=_titLabNameArr[section];
    
    return rowArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titLabNameArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CMMySubCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"CMMySubCell"];
    if (!tableCell) {
        tableCell=[[NSBundle mainBundle]loadNibNamed:@"CMMySubCell" owner:nil options:nil].firstObject;
    }
    NSArray *nameArr=_titLabNameArr[indexPath.section];
    NSArray *imageArr=_titImageArr[indexPath.section];
    [tableCell cm_functionTileLabNameStr:nameArr[indexPath.row]
                          titleImageName:imageArr[indexPath.row]];
    
  
    
    
    return tableCell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {  //我的申购记录
                    CMCommWebViewController *commWebVC = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
                    commWebVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url, @"/Account/SubscribeList");
                    [self.navigationController pushViewController:commWebVC animated:YES];
               
                 }
                    break;
                case 1:
                {//中签查询
                    CMJackpotViewController *jackpotVC = (CMJackpotViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMJackpotViewController"];
                    
                    [self.navigationController pushViewController:jackpotVC animated:YES];
                }
                    break;
                case 2:
              {
                    {//我的倍利宝
                        CMCommWebViewController *commWebVC = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
                        commWebVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url, @"/Account/FundSubscribeList");
                        [self.navigationController pushViewController:commWebVC animated:YES];
                    }
                    
                }
                    break;
                    
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                 //新品申购
                    CMSubscribeViewController *webVC = (CMSubscribeViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMSubscribeViewController"];
                    
                    [self.navigationController pushViewController:webVC animated:YES];
                    
                    
                }
                    break;
                case 1:
                {
                    CMSubscribeGuideViewController *subscribeGuideVC = (CMSubscribeGuideViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMSubscribeGuideViewController"];
                    [self.navigationController pushViewController:subscribeGuideVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            break;
        default:
            break;
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
