//
//  CMYCFPrCell.m
//  CMZC
//
//  Created by 云财富 on 2019/11/1.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMYCFPrCell.h"
#import "CMHomeDQCell.h"
@interface CMYCFPrCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIView *lineView_01;
@property(nonatomic,strong)UICollectionViewFlowLayout  *PrFlowLayout;
@property(nonatomic,strong)UICollectionView *PrCollectionView;
@property(nonatomic,assign)float height;
@end
@implementation CMYCFPrCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.lineView_01];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
            make.height.equalTo(@1);
        }];
        [self.lineView_01 mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.left.bottom.right.equalTo(self.contentView);
                  make.height.equalTo(@10);
              }];
        
        
        
        
        
        _height=170;
          
          [self addSubview:self.PrCollectionView];
           [self.PrCollectionView registerClass:[CMHomeDQCell class] forCellWithReuseIdentifier:@"CMHomeDQCell"];
          
          UIButton *dingQiLeftButton=[UIButton buttonWithType:UIButtonTypeCustom];
          [dingQiLeftButton setBackgroundColor:[UIColor whiteColor]];
          [dingQiLeftButton setImage:[UIImage imageNamed:@"home_left_icon.png"] forState:UIControlStateNormal];
          
          [self addSubview:dingQiLeftButton];
          [dingQiLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
              make.height.equalTo(@130);
              make.left.equalTo(self.mas_left);
              make.top.equalTo(self.mas_top).offset(40);
              make.width.equalTo(@30);
          }];
          
          UIButton *dingQiRightButton=[UIButton buttonWithType:UIButtonTypeCustom];
          [dingQiRightButton setBackgroundColor:[UIColor whiteColor]];
          [dingQiRightButton setImage:[UIImage imageNamed:@"home_right_icon.png"] forState:UIControlStateNormal];
          [self addSubview:dingQiRightButton];
          [dingQiRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
              make.height.width.top.equalTo(dingQiLeftButton);
              make.right.equalTo(self.mas_right);
              
          }];
          
          [dingQiLeftButton addTarget:self action:@selector(previousDingqiView:) forControlEvents:UIControlEventTouchUpInside];
          [dingQiRightButton addTarget:self action:@selector(nextDingqiView:) forControlEvents:UIControlEventTouchUpInside];
          
        
        
    }
    return self;
}
#pragma mark Lazy
-(UIView*)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=[UIColor clmHex:0xefeff4];
    }
    return _lineView;
}
-(UIView*)lineView_01{
    if (!_lineView_01) {
        _lineView_01=[[UIView alloc]init];
        _lineView_01.backgroundColor=[UIColor clmHex:0xefeff4];
    }
    return _lineView_01;
}

-(UICollectionViewFlowLayout*)PrFlowLayout{
    if (!_PrFlowLayout) {
        _PrFlowLayout=[[UICollectionViewFlowLayout alloc]init];
        _PrFlowLayout.itemSize = CGSizeMake(kScreen_width,_height);
        _PrFlowLayout.headerReferenceSize = CGSizeMake(0.0, 0.0);
        _PrFlowLayout.footerReferenceSize=CGSizeMake(0, 0);
        _PrFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _PrFlowLayout.minimumLineSpacing = 0;
        _PrFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _PrFlowLayout.minimumInteritemSpacing = 0;
        
    }
    return _PrFlowLayout;
}

-(UICollectionView*)PrCollectionView{
    
    if (!_PrCollectionView) {
        _PrCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, kScreen_width, _height) collectionViewLayout:self.PrFlowLayout];
        _PrCollectionView.dataSource = self;
        _PrCollectionView.delegate = self;
        _PrCollectionView.showsHorizontalScrollIndicator=NO;
        _PrCollectionView.showsVerticalScrollIndicator=NO;
        _PrCollectionView.backgroundColor = [UIColor whiteColor];
        _PrCollectionView.pagingEnabled=YES;
    }
    return _PrCollectionView;
}

//创建CEll
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        CMHomeDQCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CMHomeDQCell" forIndexPath:indexPath];
    
        cell.delegate=self;
    
    id HappyModel=_prDataArray[indexPath.row];

    if ([HappyModel isKindOfClass:[CMYCFPrModel class]]) {
       cell.YCFListModel=HappyModel;
    }
    
    return cell;
}

//多少个区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个区单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _prDataArray.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if ([self.delegate respondsToSelector:@selector(DingQiBaoEnterProductDetailControllerWithPageIndex:)]) {
        [self.delegate DingQiBaoEnterProductDetailControllerWithPageIndex:indexPath.row];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 得到每页宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    _currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
}

// 上一个
- (void)previousDingqiView:(UIButton *)sender {
    
    _currentPage --;
    if (_currentPage < 0) {
        // return;
        _currentPage = _prDataArray.count - 1;
    }
    [self.PrCollectionView setContentOffset:CGPointMake(_currentPage * self.PrCollectionView.frame.size.width, 0) animated:YES];
}

// 下一个
- (void)nextDingqiView:(UIButton *)sender {
    
    _currentPage ++;
    if (_currentPage >= _prDataArray.count) {
        _currentPage = 0;
        
        
        //return;
    }
    [self.PrCollectionView setContentOffset:CGPointMake(_currentPage * self.PrCollectionView.frame.size.width, 0) animated:YES];
}
-(void)setPrDataArray:(NSMutableArray *)prDataArray{
    _prDataArray=prDataArray;
    
    [self.PrCollectionView reloadData];
}
-(void)CanBtnEvent{
    
    if ([self.delegate respondsToSelector:@selector(DingQiBaoEnterPayControllerWithPageIndex:)]) {
        [self.delegate DingQiBaoEnterPayControllerWithPageIndex:_currentPage];
    }
}
-(void)dingJoinBtnClick{
    if ([self.delegate respondsToSelector:@selector(DingQiBaoEnterPayControllerWithPageIndex:)]) {
        [self.delegate DingQiBaoEnterPayControllerWithPageIndex:_currentPage];
    }
    
}


@end
