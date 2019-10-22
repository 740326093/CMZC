//
//  CMNewNoticeController.m
//  CMZC
//
//  Created by 云财富 on 2019/10/17.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMNewNoticeController.h"
#import "NSMutableAttributedString+AttributedString.h"
@interface CMNewNoticeController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *bottomLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation CMNewNoticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //UIColorFromRGB(0xfa3e19)
    _contentLab.text=@"      因新经板二级市场交易规模逐步增大，为提升用户交易体验和满足大规模交易需求。现对新经板二级市场交易系统进行扩容升级，系统升级期间，二级市场将暂停开放，待平台完成全部系统升级后会另行公告，及时通知广大用户。\n      二级市场交易系统升级期间，一级市场正常运营，用户可以正常申购优质拟上市好项目，享10倍收益。\n     具体问题可以联系新经板客服小新：微信号xinjingbantz";
    if (_contentLab.text.length>0) {
        
  
    _contentLab.lineBreakMode = NSLineBreakByCharWrapping;
    NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString: _contentLab.text];
    NSRange PayFromRang1 = [ _contentLab.text rangeOfString:@"xinjingbantz"];
    
    [Pay addAttribute:NSForegroundColorAttributeName value:[UIColor cmThemeCheng] range:NSMakeRange(PayFromRang1.location,PayFromRang1.length)];
    _contentLab.attributedText = Pay;
     }
    _bottomLab.text=@"新经板运营中心";
    _timeLab.text=@"2019年10月21日";
    
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
