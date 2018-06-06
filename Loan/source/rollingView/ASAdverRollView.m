//
//  ASAdverRollView.m
//  ASAdverRollView
//
//  Created by haohao on 16/11/4.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASAdverRollView.h"
#define kRollViewWidth self.frame.size.width
#define kRollViewheight self.frame.size.height
@interface ASAdverRollView ()
/**
 *  滚动的label
 */
@property (nonatomic, strong) UILabel *scroLabelOne;
@property (nonatomic, strong) UILabel *scroLabelTwo;

/**
 *  定时器
 */
@property (nonatomic, retain) dispatch_source_t timer;
@property (nonatomic, assign) NSInteger index;
@end

@implementation ASAdverRollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self creatUI];
    }
    return self;
}

-(UILabel *)scroLabelOne
{
    if (!_scroLabelOne) {
        _scroLabelOne = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kRollViewWidth, kRollViewheight)];
        _scroLabelOne.font = [UIFont systemFontOfSize:14];
        _scroLabelOne.textAlignment = NSTextAlignmentLeft;
        _scroLabelOne.textColor = [UIColor lightGrayColor];
    }
    return _scroLabelOne;
}

-(UILabel *)scroLabelTwo
{
    if (!_scroLabelTwo) {
        _scroLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(0, kRollViewheight, kRollViewWidth, kRollViewheight)];
        _scroLabelTwo.font = [UIFont systemFontOfSize:14];
        _scroLabelTwo.textAlignment = NSTextAlignmentLeft;
        _scroLabelTwo.textColor = [UIColor lightGrayColor];
    }
    return _scroLabelTwo;
}

-(void)creatUI
{
    self.userInteractionEnabled = YES;
    [self addTapGesture];
    //默认时间间隔
    self.interval = 2.0f;
    self.index = 0;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scroLabelOne];
    [self addSubview:self.scroLabelTwo];
}

-(void)addTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickEvent:)];
    [self addGestureRecognizer:tap];
}

-(void)clickEvent:(UITapGestureRecognizer *)sender
{
    if (self.clickBlock) {
        self.clickBlock(self.index);
    }
}

-(void)setAsBGColor:(UIColor *)asBGColor
{
    _asBGColor = asBGColor;
    self.backgroundColor = asBGColor;
}

-(void)setFont:(UIFont *)font
{
    _font = font;
    self.scroLabelOne.font = font;
    self.scroLabelTwo.font = font;
}

-(void)setFontColor:(UIColor *)fontColor
{
    _fontColor = fontColor;
    self.scroLabelOne.textColor = fontColor;
    self.scroLabelTwo.textColor = fontColor;
}

-(void)setAlignment:(NSTextAlignment)alignment
{
    _alignment = alignment;
    self.scroLabelOne.textAlignment = alignment;
    self.scroLabelTwo.textAlignment = alignment;
}

-(void)startScroll
{
    self.scroLabelOne.text = self.adverTitles[self.index];
    if (!self.timer) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),self.interval*NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(self.timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self animationToScroll];
            });
        });
        dispatch_resume(self.timer);
    }
}

-(void)animationToScroll
{
    __block UILabel *oneLabel;
    __block UILabel *twoLabel;
    __weak typeof(self) weakself = self;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)obj;
            NSString * title = weakself.adverTitles[self.index];
            if ([label.text isEqualToString:title]) {
                oneLabel = label;
            }else{
                twoLabel = label;
            }
        }
    }];
    
    [self aboutIndex];
    
    twoLabel.text = self.adverTitles[self.index];
    [UIView animateWithDuration:self.interval - 1.0 animations:^{
        oneLabel.frame = CGRectMake(0, -kRollViewheight, kRollViewWidth, kRollViewheight);
        twoLabel.frame = CGRectMake(0, 0, kRollViewWidth, kRollViewheight);
    } completion:^(BOOL finished){
        oneLabel.frame = CGRectMake(0, kRollViewheight, kRollViewWidth, kRollViewheight);
    }];
}


-(void)aboutIndex
{
    if (self.index != self.adverTitles.count - 1) {
        self.index++;
    }else{
        self.index = 0;
    }
}


-(void)endScroll
{
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}


- (void)drawRect:(CGRect)rect {
    
}

@end
