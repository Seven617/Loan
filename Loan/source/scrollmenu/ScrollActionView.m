//
//  ScrollActionView.m
//  ScrollAction
//
//  Created by 我来修修——developer on 2018/4/17.
//  Copyright © 2018年 SG-XR. All rights reserved.
//

#import "ScrollActionView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define MAIN_RGBColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
#define  IPH(asd) ((asd/667.0f)*[UIScreen mainScreen].bounds.size.height)
#define  IPW(asd) ((asd/375.0f)*[UIScreen mainScreen].bounds.size.width)
@implementation ScrollActionButtonView
- (instancetype)initWithFrame:(CGRect)frame WithImageName:(NSString *)iconImageName WithTitle:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *iconImageview = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-(self.frame.size.height-15)*0.7)*0.5, 0,IPW((self.frame.size.height-15)*0.7),IPH((self.frame.size.height-15)*0.7))];
        [iconImageview sd_setImageWithURL:[NSURL URLWithString:iconImageName] placeholderImage:[UIImage imageNamed:@"apple"]];
        iconImageview.layer.cornerRadius = 10.0;
        iconImageview.clipsToBounds = true;
        [self addSubview:iconImageview];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(iconImageview.frame) + 5, self.frame.size.width, IPH((self.frame.size.height-15)*0.3))];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor lightGrayColor];
        [self addSubview:label];
    }
    return self;
}
@end

@interface ScrollActionView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIButton *actionButton;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView *scrollerView;
@end
#define MORGEN 15 //间距
#define NUMBER 8 //个数
@implementation ScrollActionView
-(id)initWithFrame:(CGRect)frame WithSourceArray:(NSArray *)array WithIconArray:(NSArray *)iconArray{
   self = [super initWithFrame:frame];
    if (self) {
        [self createShareAcitonViewWithFrame:frame WithSourceArray:array WithIconArray:iconArray];
    }
    return self;
}
- (void)createShareAcitonViewWithFrame:(CGRect)frame WithSourceArray:(NSArray *)arr WithIconArray:(NSArray *)iconArray{
    
    NSInteger count = arr.count;
    NSInteger page = 0;
    page = count/NUMBER;
    if ( count%NUMBER != 0) {
        page = page + 1;
    }
    NSInteger row = 1;
    if (count > 4) {
        row = 2;
    }
    
    _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width, IPH(self.frame.size.height-20))];
    _scrollerView.backgroundColor = MAIN_RGBColor(242, 245, 247,1);
    _scrollerView.pagingEnabled = YES;
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.delegate = self;
    _scrollerView.bounces = NO;
    _scrollerView.contentSize = CGSizeMake(self.frame.size.width * page,0);
    [self addSubview:_scrollerView];
    

    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width - 100)/2.0, self.frame.size.height - 20, IPW(100), IPH(20))];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = page;
    [_pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
    
     for (int p = 0; p < page; p++) {
         UIView *multView = [[UIView alloc]initWithFrame:CGRectMake(_scrollerView.frame.size.width * p, 0, _scrollerView.frame.size.width, _scrollerView.frame.size.height)];
         multView.backgroundColor = UIColor.whiteColor;
         [_scrollerView addSubview:multView];
         int columns = 4;//一行个数
         CGFloat actionW = (self.frame.size.width - MORGEN*(columns+1))/columns;
         CGFloat actionH = actionW;
         for (int i = p*NUMBER; i < arr.count; i++) {
              if (i < (p+1)*NUMBER) {
             int colidx = (i % NUMBER) % columns;//取余
             int rowidx = (i % NUMBER) / columns;//取商
             CGFloat actionX = (MORGEN+actionW)*colidx+MORGEN;
             CGFloat actionY = (MORGEN+actionH)*rowidx+MORGEN;
             ScrollActionButtonView *actionView = [[ScrollActionButtonView alloc]initWithFrame:CGRectMake(actionX, actionY, actionW, actionH)  WithImageName:iconArray[i] WithTitle:arr[i]];
             actionView.tag = i;
             actionView.backgroundColor = UIColor.whiteColor;
             [multView addSubview:actionView];
             self.actionButton = actionView;
             [self.actionButton addTarget:self action:@selector(actionSend:) forControlEvents:UIControlEventTouchUpInside];
              }
         }

     }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/self.frame.size.width;
    _pageControl.currentPage = page;
}
- (void)pageControlClick:(UIPageControl *)sender {
    [self.scrollerView setContentOffset:CGPointMake(sender.currentPage*self.frame.size.width, 0) animated:YES];
}
- (void)actionSend:(UIButton *)send{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(actionToPlatWithIndex:)]) {
        [self.delegate actionToPlatWithIndex:send.tag];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
