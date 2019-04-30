//
//  CMPeiNumCell.m
//  CMZC
//
//  Created by WangWei on 2019/3/21.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import "CMPeiNumCell.h"
#import "CMBeginNUmModel.h"
@interface CMPeiNumCell()
@property(nonatomic,strong)UILabel *beginNumLab;
@property(nonatomic,strong)UILabel *FirstLab;

@property(nonatomic,strong)UILabel *NewAddLab;
@property(nonatomic,strong)UITextView *NewAddTextView;
@end
@implementation CMPeiNumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark Lazy
-(UILabel*)beginNumLab{
    if (!_beginNumLab) {
        _beginNumLab=[[UILabel alloc]init];
        _beginNumLab.textColor=[UIColor clmHex:0x999999];
        _beginNumLab.text=@"起始配号:  ";
        _beginNumLab.font=[UIFont systemFontOfSize:14.0];
    }
    return _beginNumLab;
    
}

-(UILabel*)FirstLab{
    if (!_FirstLab) {
        _FirstLab=[[UILabel alloc]init];
        _FirstLab.textColor=[UIColor clmHex:0x999999];
        _FirstLab.text=@"新增配号:  ";
        _FirstLab.font=[UIFont systemFontOfSize:14.0];
    }
    return _FirstLab;
    
}

-(UILabel*)NewAddLab{
    if (!_NewAddLab) {
        _NewAddLab=[[UILabel alloc]init];
        _NewAddLab.textColor=[UIColor clmHex:0x999999];
        _NewAddLab.numberOfLines=0;
        _NewAddLab.font=[UIFont systemFontOfSize:14.0];
        _NewAddLab.lineBreakMode = NSLineBreakByCharWrapping;
       
    }
    return _NewAddLab;
    
}
-(UITextView*)NewAddTextView{
    
    
    if (!_NewAddTextView) {
        _NewAddTextView=[[UITextView alloc]init];
        _NewAddTextView.textColor=[UIColor clmHex:0x999999];
        _NewAddTextView.font=[UIFont systemFontOfSize:14.0];
        _NewAddTextView.editable=NO;
        _NewAddTextView.scrollEnabled=NO;
        _NewAddTextView.backgroundColor=[UIColor clmHex:0xefeff4];
        
    }
    return _NewAddTextView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clmHex:0xefeff4];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self addSubview:self.beginNumLab];
        [self addSubview:self.FirstLab];
        [self addSubview:self.NewAddLab];
        [self addSubview:self.NewAddTextView];
    }
    return self;
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    [self.beginNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    
    [self.FirstLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.beginNumLab.mas_bottom).offset(10);
        make.left.equalTo(self.beginNumLab);
        make.width.equalTo(@64);
    }];
    
    [self.NewAddTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(self.FirstLab.mas_right).offset(5);
        make.top.equalTo(self.FirstLab.mas_top).offset(-8);
    }];
    
}
//-(void)setPrwin:(CMWinning *)Prwin{
//
//    if (Prwin.zqList != nil) {
//        NSArray *listArr = [Prwin.zqList componentsSeparatedByString:@","];
//        //self.beginNumLab.text = [NSString stringWithFormat:@"起始配号:  %@",listArr[0]];
//        NSMutableArray *sepArray=[NSMutableArray arrayWithArray:listArr];
//        [sepArray removeObjectAtIndex:0];
//        NSString *sepStr=[sepArray componentsJoinedByString:@","];
//        self.NewAddLab.text=sepStr;
//
//
//    }
//
//
//}
-(void)setBeginEndArray:(NSMutableArray *)beginEndArray{
    
    if (beginEndArray.count>0) {
        
        NSMutableArray *dataArrary=[NSMutableArray arrayWithCapacity:0];
        for (CMBeginNUmModel *numModel in beginEndArray) {
            [dataArrary addObject:numModel.numer];
        }
       
        NSString *beginStr=[dataArrary componentsJoinedByString:@","];
        self.beginNumLab.text = [NSString stringWithFormat:@"起始配号:  %@",beginStr];
    }
}
-(void)setCustomArray:(NSMutableArray *)customArray{
    
    if (customArray.count>0) {
        
        NSMutableArray *dataArrary=[NSMutableArray arrayWithCapacity:0];
        NSMutableAttributedString *attribut=[[NSMutableAttributedString alloc]init];
        
        for (CMBeginNUmModel *numModel in customArray) {
            [dataArrary addObject:numModel.numer];
        NSMutableAttributedString *stringAtt=[[NSMutableAttributedString alloc]initWithString:CMStringWithPickFormat(numModel.numer,@",")];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            paragraphStyle.lineSpacing = 5;    //行间距
            [stringAtt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, numModel.numer.length)];
            [stringAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, numModel.numer.length)];
            [stringAtt addAttribute:NSForegroundColorAttributeName value:numModel.statusColor range:NSMakeRange(0, numModel.numer.length)];
            [attribut appendAttributedString:stringAtt];
            
        }
        
        NSString *beginStr=[dataArrary componentsJoinedByString:@","];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:beginStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.lineSpacing = 5;    //行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, beginStr.length)];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, beginStr.length)];
         [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor clmHex:0x999999] range:NSMakeRange(0, beginStr.length)];
        
        self.NewAddTextView.attributedText = attribut;
        //self.NewAddTextView.text=beginStr;
      
    }
    
}



+ (CGFloat)heightWithModel:(NSMutableArray*)model{
    CMPeiNumCell *cell = [[CMPeiNumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    [cell setCustomArray:model];
    [cell layoutIfNeeded];
    CGRect frame=cell.NewAddTextView.frame;
    
    
    
    return frame.origin.y + frame.size.height ;
}

@end
