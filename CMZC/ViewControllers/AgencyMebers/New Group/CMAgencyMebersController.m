//
//  CMAgencyMebersController.m
//  CMZC
//
//  Created by WangWei on 2018/1/31.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMAgencyMebersController.h"
#import "CMAgencyHeadView.h"
#import "CMAgencyFootView.h"

#import "CMAgencyMessageCell.h"
#import "CMShareView.h"
#import "CMAgencesRequest.h"
#import "CMPickerView.h"
#import "CMAgencyHeadFootView.h"

@interface CMAgencyMebersController ()<UITableViewDelegate,UITableViewDataSource,CMAgencyHeadFootViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property(nonatomic,copy)NSString *selectAddress;
@property(nonatomic,assign)NSInteger selectType;

@end

@implementation CMAgencyMebersController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarBtn.frame = CGRectMake(0, 0, 30, 40);
    [rightBarBtn setImage:[UIImage imageNamed:@"newShare"] forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(pageShareView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
   CMAgencyHeadView *headView=[CMAgencyHeadView initByNibForClassName];
   
    headView.delegate=self;
    _curTableView.tableHeaderView=headView;
    UIView  *footView=[[UIView  alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), 400)];
    footView.backgroundColor=[UIColor clmHex:0xefeff4];
    _selectType=0;
    
  //  CMAgencyFootView *AgencyFootView=[CMAgencyFootView initByNibForClassName];
    CMAgencyFootView *AgencyFootView=[[CMAgencyFootView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), 300)];
    [footView addSubview:AgencyFootView];
    _curTableView.tableFooterView=footView;
    
}
-(void)pageShareView{
    
CMShareView *shareView=[[CMShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height())];
shareView.contentUrl =CMStringWithPickFormat(kCMMZWeb_url, @"/Account/AgencyMember.aspx");
shareView.titleConten = @"快上车，新经板【机构会员】福利来了！";
shareView.controller=self;
shareView.contentStr = @"加入新经板发行人，让项目融资多又快；成为管理人，获得高收益项目优先投资权；晋升保荐人，独家代理优质项目，佣金高，返还快。";
shareView.ShareImageName=[UIImage imageNamed:@"share_image"];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 570;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        CMAgencyMessageCell *AgencyMessageCell=[tableView dequeueReusableCellWithIdentifier:@"AgencyRegistCell"];
        if (!AgencyMessageCell) {
            AgencyMessageCell=[[NSBundle mainBundle]loadNibNamed:@"CMAgencyMessageCell" owner:nil options:nil].firstObject ;
        }
        AgencyMessageCell.AgencyMebersController=self;
        AgencyMessageCell.selectIndex=_selectType;
        return AgencyMessageCell;
    
}

- (void)selectItemIndex:(NSInteger)index{
    
    _selectType=index;
    
    NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
    
    [_curTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];

    
}


#pragma mark
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(CMIsLogin()){
        return 0.001;
        
    }else{
        
        return 230;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (CMIsLogin()) {
        return nil;
    }else{
        
        CMAgencyHeadFootView *AgencyHeadFootView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AgencyHeadFootView"];
        if (!AgencyHeadFootView) {
            AgencyHeadFootView=[CMAgencyHeadFootView initByNibForClassName] ;
        }
        AgencyHeadFootView.delegate=self;
    
        return AgencyHeadFootView;
        
    }
    
    
}
- (void)loginBtnEvent{
    
    if (CMIsLogin()) {
        
        [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
     
    }
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = 230;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else
        if(scrollView.contentOffset.y >= sectionHeaderHeight){
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
}


@end
