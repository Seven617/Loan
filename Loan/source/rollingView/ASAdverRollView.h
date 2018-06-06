//
//  ASAdverRollView.h
//  ASAdverRollView
//
//  Created by haohao on 16/11/4.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickBlock)(NSInteger index);
@interface ASAdverRollView : UIView
/**
 *  广告内容数组
 */
@property (nonatomic, strong)NSArray *adverTitles;

/**
 *  广告的字体样式
 */
@property (nonatomic, strong) UIFont *font;

/**
 *  广告内容字体颜色
 */
@property (nonatomic, strong) UIColor *fontColor;

/**
 *  轮播时间
 */
@property (nonatomic, assign) NSTimeInterval interval;

/**
 *  文本对齐方式
 */
@property (nonatomic, assign) NSTextAlignment alignment;

/**
 *  背景色
 */
@property (nonatomic, strong) UIColor *asBGColor;

/**
 *  点击的block
 */
@property (nonatomic, copy) ClickBlock clickBlock;
/**
 *  轮播启动
 */
-(void)startScroll;
/**
 *  停止轮播
 */
-(void)endScroll;

@end
