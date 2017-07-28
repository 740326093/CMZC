//
//  SDCollectionViewCell.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//




#import "SDCollectionViewCell.h"

@implementation SDCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
    }
    
    return self;
}




-(UIImageView*)imageView{
    if (!_imageView) {
    _imageView = [[UIImageView alloc] init];
     _imageView.frame = self.bounds;
    }
    return _imageView;
}

@end
