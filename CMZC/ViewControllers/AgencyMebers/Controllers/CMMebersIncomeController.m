//
//  CMMebersIncomeController.m
//  CMZC
//
//  Created by WangWei on 2018/2/1.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMMebersIncomeController.h"
#import "CMMebersHeadView.h"
#import "CMAssociateCell.h"
#import "CMAssociateDetailCell.h"
#import "CMConsultController.h"
#import "CMHangtagApplyController.h"
#import "CMUnderwritingListController.h"
#import "CMApplyProjectListController.h"
#import "CMMyConcessionController.h"
#import "CMAgenceMemberModel.h"
@interface CMMebersIncomeController ()<UITableViewDelegate,UITableViewDataSource,CMAssociateCellDelegate,CMMebersHeadView>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (nonatomic,strong)NSArray *imageArr;
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray *DetailArr;

@property (nonatomic,strong)CMMebersHeadView *headView;

@property (nonatomic,strong)CMAgenceMemberModel *AgenceMemberModel;
@end

@implementation CMMebersIncomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout =UIRectEdgeNone;
        
    }
    DeleteDataFromNSUserDefaults(@"THJLID");
    DeleteDataFromNSUserDefaults(@"OrgType");
    DeleteDataFromNSUserDefaults(@"OrgJianCheng");
    [self showDefaultProgressHUD];
    _curTableView.hidden=YES;
    [self getMessage];
    _curTableView.tableHeaderView=self.headView;
    _imageArr=@[@"itemStyleImage_01",@"itemStyleImage_02",@"itemStyleImage_03"];
    _DetailArr=@[@"融资对接项目百亿资本联盟,融资速度快,最快两周",@"独家代理权,佣金高,赚的多,返还迅速",@"佣金高,返佣快"];
   
}
-(NSArray*)titleArr{
    if(!_titleArr){
        _titleArr=[NSArray array];
    }
    return _titleArr;
}

-(CMMebersHeadView*)headView{
    if (!_headView) {
        _headView=[CMMebersHeadView initByNibForClassName];
        _headView.delegate=self;
    }
    return _headView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _imageArr.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        return 120;
    }else{
        return 75;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
       
        CMAssociateCell *AssociateCell=[tableView dequeueReusableCellWithIdentifier:@"AssociateCell"];
        if (!AssociateCell) {
           
            AssociateCell=[CMAssociateCell initByNibForClassName];
            
        }
        AssociateCell.agencyModel= _AgenceMemberModel;
        AssociateCell.delegate=self;
        return AssociateCell;
        
    } else {
        
        CMAssociateDetailCell *AssociateDetailCell=[tableView dequeueReusableCellWithIdentifier:@"AssociateDetailCell"];
        if (!AssociateDetailCell) {
            
            AssociateDetailCell=[CMAssociateDetailCell initByNibForClassName];
        }
        
        if (_titleArr.count>0) {
            
     
        AssociateDetailCell.leftImage=_imageArr[indexPath.row-1];
        AssociateDetailCell.leftTitle=_titleArr[indexPath.row-1];
        AssociateDetailCell.leftDetail=_DetailArr[indexPath.row-1];
        if (indexPath.row==1) {
            AssociateDetailCell.incomeLabe.hidden=YES;
        }else if(indexPath.row==2){
             AssociateDetailCell.incomeLabe.hidden=NO;
            AssociateDetailCell.incomeLabe.text=[NSString stringWithFormat:@"%@个",_AgenceMemberModel.YouZhiProjectCount];
            [self LoneAttributedStringEndString:@"个" FromLabel:AssociateDetailCell.incomeLabe withColor:[UIColor clmHex:0xff6400]];
        }else{
             AssociateDetailCell.incomeLabe.hidden=NO;
            AssociateDetailCell.incomeLabe.text=[NSString stringWithFormat:@"已赚%@元",_AgenceMemberModel.YongJin];
            [self DoubleStringChangeColer:AssociateDetailCell.incomeLabe andFromStr:@"赚" ToStr:@"元" withColor:[UIColor clmHex:0xff6400]];
           
        }
       }
    
        return AssociateDetailCell;
    }
    
   
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 1:{
            CMHangtagApplyController *HangtagApply=(CMHangtagApplyController*)[CMHangtagApplyController initByStoryboard];
            [self.navigationController pushViewController:HangtagApply animated:YES];
            
        }
            
            break;
        case 2:{
            
            CMUnderwritingListController  *ApplyProjectList=(CMUnderwritingListController*)[CMUnderwritingListController initByStoryboard];
           
            [self.navigationController pushViewController:ApplyProjectList animated:YES];
            
        }     break;
        case 3:
        {
            CMMyConcessionController *MyConcession=(CMMyConcessionController*)[CMMyConcessionController initByStoryboard];
            [self.navigationController pushViewController:MyConcession animated:YES];
            
        }
            break;
        default:
            break;
    }
}

-(void)callManagerEvent{
    //咨询
    CMConsultController  *consultController=(CMConsultController*)[CMConsultController initByStoryboard];
    consultController.type=CustomType;
    consultController.pid=@"";
    [self.navigationController pushViewController:consultController animated:YES];
    
}

-(void)enterMyApplyListWithType:(NSInteger)type{
    CMApplyProjectListController  *ApplyProjectList=(CMApplyProjectListController*)[CMApplyProjectListController initByStoryboard];
    ApplyProjectList.type=type;
    [self.navigationController pushViewController:ApplyProjectList animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 请求数据
-(void)getMessage{
    NSDictionary *messageDict=@{@"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid")};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"Get_OrganizationInfo" andMessage:messageDict success:^(id responseObj) {
        MyLog(@"机构信息+++%@",responseObj);
        if([[responseObj objectForKey:@"respCode"]integerValue]==1){
           
            [self hiddenProgressHUD];
            _curTableView.hidden=NO;
            
            _AgenceMemberModel=[CMAgenceMemberModel yy_modelWithJSON:[responseObj objectForKey:@"data"]];
            _headView.AgenceMemberModel=_AgenceMemberModel;
            SaveDataToNSUserDefaults(_AgenceMemberModel.THJLID, @"THJLID");
            SaveDataToNSUserDefaults(CMStringWithFormat(_AgenceMemberModel.OrgType), @"OrgType");
            SaveDataToNSUserDefaults(_AgenceMemberModel.OrgJianCheng, @"OrgJianCheng");
            self.title=_AgenceMemberModel.OrgJianCheng;
            if (_AgenceMemberModel.OrgType==1) {
                _titleArr=@[@"挂牌项目申请",@"优质项目承销",@"我的佣金"];
            }else{
               _titleArr=@[@"挂牌项目推荐",@"优质项目承销",@"我的佣金"];
                
            }
            [_curTableView reloadData];
            
        }
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)DoubleStringChangeColer:(UILabel *)mainStr andFromStr:(NSString *)aFromStr ToStr:(NSString *)AToStr withColor:(UIColor*)color {
    
    NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString: mainStr.text];
    NSRange PayFromRang1 = [mainStr.text rangeOfString:aFromStr];
    NSRange PayFromRang2 = [mainStr.text rangeOfString:AToStr];
   
    [Pay addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],
                               NSForegroundColorAttributeName:color
                               } range:NSMakeRange(PayFromRang1.location+1, PayFromRang2.location-PayFromRang1.location-1)];
    
    mainStr.attributedText = Pay;
    
}

-(void)LoneAttributedStringEndString:(NSString*)endStr FromLabel:(UILabel*)FromLabel withColor:(UIColor*)color{
    if(FromLabel.text){
        NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:FromLabel.text];
        
        NSRange qiToRang = [FromLabel.text rangeOfString:endStr];
        [qixianStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                   NSForegroundColorAttributeName:color
                                   } range:NSMakeRange(0, qiToRang.location)];
        FromLabel.attributedText = qixianStr;
    }
    
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
