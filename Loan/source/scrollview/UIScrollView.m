//
//  UIScrollView.m
//  Loan
//
//  Created by 冷少白 on 2018/5/31.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

#import "UIScrollView.h"
@implementation AutoLayoutScrollView


-(void) autoContentSize:(Oritation) type{
    
    CGFloat width = 0;
    CGFloat height= 0;
    
    for (UIView* view in self.subviews){
        height += view.frame.size.height;
        width += view.frame.size.width;
    }
    
    switch (type) {
            
        case horizontal:{
            self.contentSize = CGSizeMake(width, 0.0f);
        }
            break;
            
        case vertical:{
            
            self.contentSize = CGSizeMake(0.0f, height);
            
        }break;
            
        default:
            break;
    }
    
}



@end  
