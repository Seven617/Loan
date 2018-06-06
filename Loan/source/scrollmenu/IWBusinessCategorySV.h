//
//  IWBusinessCategorySV.h
//  01-CategoryView
//
//  Created by bobo on 2016/10/29.
//  Copyright © 2016年 huangshaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN const NSInteger KCategoryTag;

@interface IWBusinessCategorySV : UIView

/**
 实例化

 @param frame      frame
 @param imageArray 图片数组
 @param titleArray 标题数组
 @param target     target
 @param action     分类按钮点击事件

 @return 分类视图
 */
+ (IWBusinessCategorySV *)businessCategorySVWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray target:(id)target action:(SEL)action;

@end
