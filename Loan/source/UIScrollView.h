//
//  UIScrollView.h
//  Loan
//
//  Created by 冷少白 on 2018/5/31.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

#ifndef UIScrollView_h
#define UIScrollView_h


#endif /* UIScrollView_h */
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, Oritation) {
    
    horizontal = 1,
    vertical,
    
};

/**
 解决自适应滚动
 */
@interface AutoLayoutScrollView : UIScrollView



/**
 自适应内容滚动尺寸
 
 @param type 滚动方向
 */
-(void) autoContentSize:(Oritation) type;

@end  
