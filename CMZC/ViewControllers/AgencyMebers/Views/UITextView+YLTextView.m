//
//  UITextView+YLTextVIew.m
//  CMZC
//
//  Created by WangWei on 2018/2/2.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "UITextView+YLTextView.h"
#import <objc/runtime.h>
@interface UITextView ()
@property (nonatomic,strong) UILabel *placeholderLabel;//占位符
@property (nonatomic,strong) UILabel *wordCountLabel;//计算字数
@property (nonatomic,strong) NSValue *oldFrame;//记录初始frame
@property (nonatomic,strong) UIImageView *placeholderImage;//占位符
@end
@implementation UITextView (YLTextView)

static NSString *PLACEHOLDLABEL = @"placelabel";
static NSString *PLACEHOLDImage = @"placeImage";
static NSString *PLACEHOLD = @"placehold";
static NSString *PLACEHOLDImageName = @"placeImageName";
static NSString *PLACEHOLDFONT = @"placeholdfont";
static NSString *LIMITFONT = @"limitfont";
static NSString *PLACEHOLDCOLOR = @"placeholdcolor";
static NSString *LIMITCOLOR = @"limitcolor";
static NSString *AUTOHEIGHT = @"autoheight";
static NSString *OLDFRAME = @"oldframe";
static const void *limitLengthKey = &limitLengthKey;
static const void *limitLinesKey = &limitLinesKey;

#pragma mark -- set/get...

- (void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    objc_setAssociatedObject(self, &PLACEHOLDLABEL, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UILabel *)placeholderLabel {
    return objc_getAssociatedObject(self, &PLACEHOLDLABEL);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setPlaceholderImage:(UIImageView *)placeholderImage{
    objc_setAssociatedObject(self, &PLACEHOLDImage, placeholderImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImageView *)placeholderImage {
    return objc_getAssociatedObject(self, &PLACEHOLDImage);
}


//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, &PLACEHOLD, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setPlaceHolderLabel:placeholder];
}
- (NSString *)placeholder {
    return objc_getAssociatedObject(self, &PLACEHOLD);
}



//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (NSNumber *)limitLength {
    return objc_getAssociatedObject(self, limitLengthKey);
}
- (void)setLimitLength:(NSNumber *)limitLength {
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:self];
   // [self setWordcountLable:limitLength];
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (NSNumber *)limitLines {
    return objc_getAssociatedObject(self, limitLinesKey);
}
- (void)setLimitLines:(NSNumber *)limitLines {
    objc_setAssociatedObject(self, limitLinesKey, limitLines, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:self];
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setLimitPlaceFont:(UIFont *)limitPlaceFont {
    if (self.wordCountLabel) {
        self.wordCountLabel.font = limitPlaceFont;
    }
    objc_setAssociatedObject(self, &LIMITFONT, limitPlaceFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIFont *)limitPlaceFont {
    return objc_getAssociatedObject(self, &LIMITFONT) == nil ? [UIFont systemFontOfSize:13.] : objc_getAssociatedObject(self, &LIMITFONT);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setPlaceholdFont:(UIFont *)placeholdFont {
    if (self.placeholderLabel) {
        self.placeholderLabel.font = placeholdFont;
    }
    objc_setAssociatedObject(self, &PLACEHOLDFONT, placeholdFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIFont *)placeholdFont {
    return objc_getAssociatedObject(self, &PLACEHOLDFONT) == nil ? [UIFont systemFontOfSize:13.] : objc_getAssociatedObject(self, &PLACEHOLDFONT);
}
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setPlaceholderImageName:(NSString *)placeholderImageName {
    if (self.placeholderImage) {
        self.placeholderImage.image = [UIImage imageNamed:placeholderImageName];
    }
    objc_setAssociatedObject(self, &PLACEHOLDImageName, placeholderImageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)placeholderImageName {
    return objc_getAssociatedObject(self, &PLACEHOLDImageName);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setPlaceholdColor:(UIColor *)placeholdColor {
    if (self.placeholderLabel) {
        self.placeholderLabel.textColor = placeholdColor;
    }
    objc_setAssociatedObject(self, &PLACEHOLDCOLOR, placeholdColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)placeholdColor {
    return objc_getAssociatedObject(self, &PLACEHOLDCOLOR) == nil ? [UIColor lightGrayColor] : objc_getAssociatedObject(self, &PLACEHOLDCOLOR);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setLimitPlaceColor:(UIColor *)limitPlaceColor {
    if (self.wordCountLabel) {
        self.wordCountLabel.textColor = limitPlaceColor;
    }
    objc_setAssociatedObject(self, &LIMITCOLOR, limitPlaceColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)limitPlaceColor {
    return objc_getAssociatedObject(self, &LIMITCOLOR) == nil ? [UIColor lightGrayColor] : objc_getAssociatedObject(self, &LIMITCOLOR);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setAutoHeight:(NSNumber *)autoHeight {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:self];
    objc_setAssociatedObject(self, &AUTOHEIGHT, autoHeight, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSNumber *)autoHeight {
    return objc_getAssociatedObject(self, &AUTOHEIGHT);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setOldFrame:(NSValue *)oldFrame {
    objc_setAssociatedObject(self, &OLDFRAME, oldFrame, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSValue *)oldFrame {
    return objc_getAssociatedObject(self, &OLDFRAME);
}
#pragma mark -- 配置占位符标签

- (void)setPlaceHolderLabel:(NSString *)placeholder {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:self];
    if (self.placeholderImage) {
        [self.placeholderImage removeFromSuperview];
    }
    
    if (self.placeholderLabel) {
        [self.placeholderLabel removeFromSuperview];
    }
    self.placeholderImage=[[UIImageView alloc]init];
    self.placeholderImage.image=[UIImage imageNamed:self.placeholderImageName];
    self.placeholderImage.userInteractionEnabled=YES;
 
    self.placeholderImage.hidden = self.text.length > 0 ? YES : NO;
    [self addSubview:self.placeholderImage];
    [self.placeholderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.left.equalTo(self.mas_left).offset(5);
    }];
    /*
     *  占位图片
     */
    /*
     *  占位字符
     */
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.font = self.placeholdFont;
    self.placeholderLabel.text = placeholder;
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.placeholderLabel.textColor = self.placeholdColor;
  //  CGRect rect = [placeholder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-17, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.placeholdFont} context:nil];
    //self.placeholderLabel.frame = CGRectMake(19, 5, rect.size.width, rect.size.height);
    [self addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.placeholderImage);
        make.left.equalTo(self.placeholderImage.mas_right).offset(3);
       // make.width.mas_equalTo(rect.size.width);
        // make.height.mas_equalTo(rect.size.height);
    }];
    self.placeholderLabel.hidden = self.text.length > 0 ? YES : NO;
   // self.wordCountLabel.text = [NSString stringWithFormat:@"%lu/%@",(unsigned long)self.text.length,self.limitLength];
    
}
/*
#pragma mark -- 配置字数限制标签

- (void)setWordcountLable:(NSNumber *)limitLength {
    if (self.wordCountLabel) {
        [self.wordCountLabel removeFromSuperview];
    }
    self.wordCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 20, CGRectGetWidth(self.frame) - 10, 20)];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    self.wordCountLabel.textColor = self.limitPlaceColor;
    self.wordCountLabel.font = self.limitPlaceFont;
    if (self.text.length > [limitLength integerValue]) {
        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
    self.wordCountLabel.text = [NSString stringWithFormat:@"%lu/%@",(unsigned long)self.text.length,limitLength];
    [self addSubview:self.wordCountLabel];
    
}
*/
#pragma mark -- NSNotification

- (void)textViewChanged:(NSNotification *)notification {
    NSInteger wordCount = self.text.length;
    if (self.placeholder) {
        self.placeholderLabel.hidden = YES;
        if (wordCount == 0) {
            self.placeholderLabel.hidden = NO;
        }
    }
    if (self.placeholderImage) {
        self.placeholderImage.hidden = YES;
        if (wordCount == 0) {
            self.placeholderImage.hidden = NO;
        }
    }
    if (self.limitLength) {//字数限制
        if (wordCount > [self.limitLength integerValue]) {
            wordCount = [self.limitLength integerValue];
        }
        NSString *keyboardType = self.textInputMode.primaryLanguage;
        if ([keyboardType isEqualToString:@"zh-Hans"]) {//对简体中文做特殊处理>>>>高亮拼写问题
            UITextRange *range = [self markedTextRange];
            if (!range) {
                if (self.text.length > [self.limitLength intValue]) {
                    self.text = [self.text substringToIndex:[self.limitLength intValue]];
                    MyLog(@"已经是最大字数");
                }else {/*有高亮不做限制*/}
            }
        }else {
            if ([self.text length] > [self.limitLength intValue]) {
                self.text = [self.text substringToIndex:[self.limitLength intValue]];
                MyLog(@"已经是最大字数");
            }
        }
    
    }else {
        if (self.limitLines) {//行数限制
            CGSize size = [self getStringPlaceSize:self.text textFont:self.font bundingSize:CGSizeMake(self.contentSize.width-10, CGFLOAT_MAX)];
            if (size.height > self.font.lineHeight * [self.limitLines intValue]) {
                self.text = [self.text substringToIndex:self.text.length - 1];
                MyLog(@"已经是最大行数/n行数限制，没有做右下角label提示,若有此需求,联系我");
            }
            /*行数的限制，没有做右下角提示*/
        }
    }
    if (self.autoHeight) {
        CGSize size = [self getStringPlaceSize:self.text textFont:self.font bundingSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT)];
        CGRect oldRect = self.oldFrame.CGRectValue;
        [UIView animateWithDuration:0.15 animations:^{
            self.frame = CGRectMake(oldRect.origin.x, oldRect.origin.y, oldRect.size.width, size.height + 25 <= oldRect.size.height ? oldRect.size.height : size.height + 25);
        }];
    }
    
}

- (CGSize)getStringPlaceSize:(NSString *)string textFont:(UIFont *)font bundingSize:(CGSize)boundSize {
    //计算文本高度
    NSDictionary *attribute = @{NSFontAttributeName:font};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [string boundingRectWithSize:boundSize options:option attributes:attribute context:nil].size;
    return size;
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
//}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.placeholder && self.placeholderLabel&&self.placeholderImage) {
       // CGRect rect = [self.placeholder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-7, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.placeholdFont} context:nil];
      //  self.placeholderLabel.frame = CGRectMake(19, 5, rect.size.width,rect.size.height);
         //self.placeholderImage.frame = CGRectMake(7, 7, 12, 12);
        
    }
    if ([self.autoHeight isEqual:@1]) {
        CGRect currentFrame = self.frame;
        self.oldFrame = [NSValue valueWithCGRect:currentFrame];
    }
}

@end
