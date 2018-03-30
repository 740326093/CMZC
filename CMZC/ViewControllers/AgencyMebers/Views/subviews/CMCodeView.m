//
//  CMCodeView.m
//  CMZC
//
//  Created by WangWei on 2018/2/7.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMCodeView.h"
@interface CMCodeView ()

@property (nonatomic, retain) NSMutableString *changeString;
@property (nonatomic, retain) UILabel *codeLabel;

@end
@implementation CMCodeView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
   
        
        self.backgroundColor = [UIColor  clmHex:0xefeff4];
      
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor  clmHex:0xefeff4];
    
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

//-(void)changeCode{
//    //[self change];
//    [self setNeedsDisplay];
//}
/*
- (void)change
{
    self.changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    self.changeArray=[_getCode componentsSeparatedByString:@","];
    
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:5];
  
    self.changeString = [[NSMutableString alloc] initWithCapacity:6];
    for(NSInteger i = 0; i < 4; i++)
    {
        NSInteger index = arc4random() % ([self.changeArray count] - 1);
        getStr = [self.changeArray objectAtIndex:index];
        
        self.changeString = (NSMutableString *)[self.changeString stringByAppendingString:getStr];
    }
}
*/
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.changeString) {
        
   
    NSString *text = [NSString stringWithFormat:@"%@",self.changeString];

    CGSize cSize = [@"S" sizeWithAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:24]}];
   
    float width = (rect.size.width
                   /text.length)-13;
    
    int height = rect.size.height - cSize.height;
    
    float interval = (rect.size.width-width*text.length)/7.0;//间隔
    
    CGPoint point;
    
    float pX, pY;
    for (int i = 0; i < text.length; i++)
    {
        pX = (width+interval) * i+interval;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        
        NSInteger R = (arc4random() % 256) ;
        NSInteger G = (arc4random() % 256) ;
        NSInteger B = (arc4random() % 256) ;
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24],NSForegroundColorAttributeName:[UIColor clmR:R G:G B:B]}];
    }
    
     }
}

- (void)tapClick:(UITapGestureRecognizer*)tap{
    if ([self.delegate respondsToSelector:@selector(changeCode)]) {
        [self.delegate changeCode];
    }
}
-(void)setGetCode:(NSString *)getCode{
    
    NSMutableArray *integerArray = [[NSMutableArray alloc] init];
    ;
    for (int i = 0; i < getCode.length; i ++) {
        NSString *subString = [getCode substringWithRange:NSMakeRange(i, 1)];
        [integerArray addObject:subString];
    }
    
   // NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:5];
    
    self.changeString = [[NSMutableString alloc] initWithCapacity:6];
    for(NSInteger i = 0; i < 5; i++)
    {
        //NSInteger index = arc4random() % ([integerArray count] - 1);
       // getStr = [integerArray objectAtIndex:i];
        
        self.changeString = (NSMutableString *)[self.changeString stringByAppendingString:[integerArray objectAtIndex:i]];
    }
    
    [self setNeedsDisplay];
}


@end
