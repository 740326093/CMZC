//
//  CMProductPullView.m
//  CMZC
//
//  Created by WangWei on 2019/3/1.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import "CMProductPullView.h"
#define ReuseIdentifier @"reuseID"


@interface CMProductPullView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel *baseView;

@property(nonatomic,strong)NSArray *titles;

@property(nonatomic,strong)UITableView *listTableView;

@end

@implementation CMProductPullView

-(instancetype)initShowTheListOnButton:(UILabel *)button Height:(CGFloat)height Titles:(NSArray *)titles
{
    self=[super init];
    if (self) {
        
    self.titles = titles;
    self.baseView = button;
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), height) style:UITableViewStylePlain];
    self.listTableView.dataSource = self;
    self.listTableView.delegate = self;

  //  pullView.frame = CGRectMake(0, 40, CMScreen_width(), 0);
    
    
   
    //[UIView animateWithDuration:1 animations:^{
        
    CMTabBarViewController  *mainTab=(CMTabBarViewController*)[UIApplication sharedApplication].delegate.window.rootViewController;
    
    UINavigationController * nav = (UINavigationController *)mainTab.selectedViewController;

    CGFloat navHeight = nav.navigationBar.frame.size.height;
        self.frame = CGRectMake(0, 40+[UIApplication sharedApplication].statusBarFrame.size.height+navHeight, CMScreen_width(), height);
    self.listTableView.frame = CGRectMake(0, 1, CMScreen_width(), height);
        
        UIView *linView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), 1)];
        linView.backgroundColor=[UIColor cmThemeCheng];
        [self addSubview:linView];
        
    //} completion:^(BOOL finished) {
        
    //}];
       // [button.superview addSubview:self];
    [self addSubview:self.listTableView];
        
    [self show];
}
    return self;
}

-(void)hideTheListViewOnButton:(UILabel *)button
{
    
    [self removeFrom];
    CGRect baseRect = button.frame;
  //  __weak typeof(self)weakSelf = self;
   // [UIView animateWithDuration:1 animations:^{
        
     
    self.frame = CGRectMake(0, baseRect.origin.y, 0, baseRect.size.height);
    self.listTableView.frame = CGRectMake(0, 0, baseRect.size.width, 0);
   
    
  //  } completion:^(BOOL finished) {
        
   // }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseIdentifier];
    }
    
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.baseView.text=self.titles[indexPath.row] ;
    
    if ([self.delegate respondsToSelector:@selector(choseTheCell:)])
    {
        [self.delegate choseTheCell:indexPath.row ];
    }
    
    [self hideTheListViewOnButton:self.baseView];
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    [window addSubview:self];
    
}
- (void)removeFrom {
    [self removeFromSuperview];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
