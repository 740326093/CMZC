//
//  CMWebHtmlTableViewCell.h
//  CMZC
//
//  Created by MAC on 17/1/7.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CMWEbHtmlBlock)();

@interface CMWebHtmlTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString *htmlString;

@property (nonatomic,copy) CMWEbHtmlBlock block;

@end
