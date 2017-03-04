//
//  CMIntrouctionView.m
//  CMZC
//
//  Created by WangWei on 17/3/3.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMIntrouctionView.h"
@interface CMIntrouctionView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *currTablview;
@property(nonatomic,strong)UIButton *isSelected;
@property(nonatomic,strong)NSDictionary *TitleDict;
@property(nonatomic,strong)NSArray *keys;
@end

@implementation CMIntrouctionView


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {

        NSArray *titileArr=@[@"注册开户",@"资金管理",@"买入赎回",@"收益分配"];
        _TitleDict=@{@"如何成为注册用户?":@[@"在注册页面，填写您真实的邮箱或手机号、密码并同意相关协议，点击‘注册'按钮即可完成注册。"],
                     @"什么是倍利宝？":@[@"倍利宝是一种创新型的投资产品，主要有三种产品组合，一种是一级市场众筹计划的组合，一种是二级市场综合投资的组合，还有一种是一级市场和二级市场资金错配进行组合的产品。可灵活赎回，不可 进入二级市场进行交易。"],
                     @"如何开户绑卡？储蓄卡吗？":@[@" 准备一张您常用的银行储蓄卡，通过后台绑定银行卡及收款人，就轻松完成开户了。"]
       
                     };
        _keys=@[@"如何成为注册用户?",
                @"什么是倍利宝？",
                @"如何开户绑卡？储蓄卡吗？"];
        for (int i=0; i<titileArr.count; i++) {
            
            UIButton  *buttonLabel=[UIButton  buttonWithType:UIButtonTypeCustom];
            buttonLabel.frame=CGRectMake(i%titileArr.count*(CMScreen_width()/4.0),0, CMScreen_width()/4.0,45);
            [buttonLabel setTitle:titileArr[i] forState:UIControlStateNormal];
            [buttonLabel setTitleColor:[UIColor clmHex:0x333333] forState:UIControlStateNormal];
            [buttonLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            buttonLabel.titleLabel.font=[UIFont systemFontOfSize:14.0];
            [buttonLabel addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            buttonLabel.tag=i+10;
             if (i==0) {
             buttonLabel.selected = YES;
             _isSelected=buttonLabel;
                 [buttonLabel setBackgroundImage:[UIImage imageNamed:@"beilIBaoButton"] forState:UIControlStateNormal];
             }
            [self addSubview:buttonLabel];
            
        }
        [self addSubview:self.currTablview];
      
        
   } 
    return self;
}
-(void)clickBtn:(UIButton*)sender{
    if (sender==_isSelected) {
        return;
    }
    _isSelected.selected=NO;
     [_isSelected setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    sender.selected=YES;
    _isSelected=sender;
    [_isSelected setBackgroundImage:[UIImage imageNamed:@"beilIBaoButton"] forState:UIControlStateNormal];
    
    
    switch (sender.tag) {
        case 10:
        {
            _TitleDict=@{@"如何成为注册用户?":@[@"在注册页面，填写您真实的邮箱或手机号、密码并同意相关协议，点击‘注册'按钮即可完成注册。"],
                         @"什么是倍利宝？":@[@"倍利宝是一种创新型的投资产品，主要有三种产品组合，一种是一级市场众筹计划的组合，一种是二级市场综合投资的组合，还有一种是一级市场和二级市场资金错配进行组合的产品。可灵活赎回，不可 进入二级市场进行交易。"],
                         @"如何开户绑卡？储蓄卡吗？":@[@" 准备一张您常用的银行储蓄卡，通过后台绑定银行卡及收款人，就轻松完成开户了。"]
                         
                         };
            _keys=@[@"如何成为注册用户?",
                    @"什么是倍利宝？",
                    @"如何开户绑卡？储蓄卡吗？"];
            
        }
            break;
        case 11:
        {
            
            _TitleDict=@{@"如何买入倍利宝产品？":@[@"产品交易以当前净值为基准价，按份申购。"],
                         @"倍利宝产品净值如何变化？":@[@"1、在产品申购成功后，可在账户中心'我的倍利宝'查询申购赎回的确认情况，并可对赎回期开放的产品份额进行赎回。",@"2、赎回期开放后，净值变化会实时体现在当日净值。 "
                                           ],
                         @"倍利宝产品资金由资金管理人管理？":@[@"资金管理人都是专业的基金经理人，承诺以诚实守信、勤勉尽责的原则管理和运用基金资产，但不保证本基金一定达到预期收益，保证最低收益"]
                         
                         };
            _keys=@[@"如何买入倍利宝产品？",
                    @"倍利宝产品净值如何变化？",
                    @"倍利宝产品资金由资金管理人管理？"];
        }
            break;
        case 12:
        {
            _TitleDict=@{@"如何买入倍利宝产品？":@[@"产品交易以当前净值为基准价，按份申购。"],
                         @"什么是倍利宝的产品封闭期？ ":@[@"产品成立初期会有一定的封闭期，期间根据每天申购的平均额度进行布局和管理。在产品封闭期间内净值不发生变化，封闭期过后展示产品的净值及每期净值变化曲线等信息。"
                                           ],
                         @"什么是倍利宝的赎回开放期？":@[@"赎回开放期是为了产品的稳定收益分配和增长而设定的，倍利宝的每笔资金都需要经历一定的赎回开放期，期间是不可以赎回的，过了既定期限就可以申请赎回。"],
                         @"倍利宝产品的收益是如何分配的？":@[@"新经板不接触交易资金，不吸储，不放贷，仅为借贷交易双方提供信息服务、信用评级及风险管理服务，这种居间服务合规合法。"]
                         
                         };
            _keys=@[@"如何买入倍利宝产品？",
                    @"什么是倍利宝的产品封闭期？ ",
                    @"什么是倍利宝的赎回开放期？",
                    @"倍利宝产品的收益是如何分配的？"];
        }
            break;
        case 13:
        {
            _TitleDict=@{@"倍利宝产品的收益是如何分配的？":@[@"1、收益分配方式：红利续投，会体现在净值当中",@"2、每一类别倍利宝份额享有同等分配权"],
                         @"倍利宝收益怎么算？":@[@"定期宝收益是按季付息，到期还本的。"
                                           ],
                         @"收益=赎回时总金额-买入成本":@[@"假如您2016年4月30号申购倍利宝1号10000份，当日净值100，2016年10月30日赎回。当日净值：110 、赎回费率：1% 、 持有份数：10000赎回后获得现金为：10000*110*（1-1%）==1089000 对比本金1000000元，投资收益为：89000"]
                         
                         };
            _keys=@[@"倍利宝产品的收益是如何分配的？",
                    @"倍利宝收益怎么算？",
                    @"收益=赎回时总金额-买入成本"];
        }
            break;
            
        default:
            break;
    }
    
    [_currTablview reloadData];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _TitleDict.allKeys.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr=[_TitleDict objectForKey:_keys[section]];
    return arr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID=@"indexPath";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSArray *arr=[_TitleDict objectForKey:_keys[indexPath.section]];

    cell.textLabel.text=arr[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:12.0];
    cell.textLabel.textColor=[UIColor clmHex:0x666666];
    cell.textLabel.numberOfLines=0;
    return cell;

}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), 20)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, CMScreen_width()-10, 20)];
    label.text=_keys[section];
    label.font=[UIFont systemFontOfSize:14.0];
    label.textColor=[UIColor clmHex:0x333333];
    [bgView addSubview:label];
    return bgView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr=[_TitleDict objectForKey:_keys[indexPath.section]];

    CGRect rect = [arr[indexPath.row] boundingRectWithSize:CGSizeMake(CMScreen_width()-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    
    
    return rect.size.height + 15 ;
}
-(UITableView*)currTablview{
    if (!_currTablview) {
        _currTablview=[[UITableView alloc]initWithFrame:CGRectMake(0,60, CMScreen_width(), 200) style:UITableViewStylePlain];
        _currTablview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _currTablview.delegate=self;
        _currTablview.dataSource=self;
        
        
        
    }
    return _currTablview;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 20; //sectionHeaderHeight
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
}

@end
