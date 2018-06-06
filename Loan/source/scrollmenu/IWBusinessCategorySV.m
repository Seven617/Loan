//
//  IWBusinessCategorySV.m
//  01-CategoryView
//
//  Created by bobo on 2016/10/29.
//  Copyright © 2016年 huangshaobin. All rights reserved.
//

#import "IWBusinessCategorySV.h"
#import "IWItemButton.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

const NSInteger KCategoryTag = 100;
static const NSInteger KPageCount = 8;//一页的个数
static const NSInteger KPageSection = 2;//一页的行数

@implementation IWBusinessCategorySV

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.设置背景颜色
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (id)businessCategorySV
{
    return [[self alloc] init];
}

+ (IWBusinessCategorySV *)businessCategorySVWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray target:(id)target action:(SEL)action
{
    IWBusinessCategorySV *businessCategorySV = [self businessCategorySV];
    businessCategorySV.frame = frame;
    
    //1.添加UIScrollView
    UIScrollView *categoryScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    categoryScrollView.pagingEnabled = YES;
    categoryScrollView.showsHorizontalScrollIndicator = YES;
    categoryScrollView.showsVerticalScrollIndicator = NO;
    NSInteger page = (titleArray.count + KPageCount - 1)/KPageCount;
    categoryScrollView.contentSize = CGSizeMake(frame.size.width * page, frame.size.height);
    [businessCategorySV addSubview:categoryScrollView];
    
    //2.添加button
    CGFloat itemBtnW = frame.size.width/(KPageCount/KPageSection);
    CGFloat itemBtnH = frame.size.height/KPageSection;
    for (int i = 0; i < titleArray.count; i ++) {
        IWItemButton *itemBtn = [IWItemButton buttonWithType:UIButtonTypeCustom];
        itemBtn.clipsToBounds = YES;
        itemBtn.layer.cornerRadius = 10;
        itemBtn.tag = i + KCategoryTag;
        [itemBtn sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"apple"]];
//        NSURL *url = [NSURL URLWithString: imageArray[i]];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        UIImage *image = [UIImage imageWithData:data];
//        itemBtn.imageView.image = image;
        
//        [itemBtn setImage:image forState:UIControlStateNormal];
        [itemBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [itemBtn setTitleColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0] forState:UIControlStateNormal];
        CGFloat itemBtnX = i/KPageCount *frame.size.width + (i%(KPageCount/KPageSection))*itemBtnW;
        CGFloat itemBtnY = ((i - (i/KPageCount)*KPageCount)/(KPageCount/KPageSection))*itemBtnH;
        itemBtn.frame = CGRectMake(itemBtnX, itemBtnY, itemBtnW, itemBtnH);
        [itemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [categoryScrollView addSubview:itemBtn];
    }
    
    return businessCategorySV;
}

@end
