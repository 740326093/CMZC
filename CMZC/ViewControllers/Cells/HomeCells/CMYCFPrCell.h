//
//  CMYCFPrCell.h
//  CMZC
//
//  Created by 云财富 on 2019/11/1.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CMYCFPrCellDelegate <NSObject>

-(void)DingQiBaoEnterPayControllerWithPageIndex:(NSInteger)pageIndex;
-(void)DingQiBaoEnterProductDetailControllerWithPageIndex:(NSInteger)pageIndex;


@end
@interface CMYCFPrCell : UITableViewCell

@property (strong, nonatomic) NSMutableArray *prDataArray;
@property(nonatomic,assign)NSInteger currentPage;


@property(nonatomic ,weak)id<CMYCFPrCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
