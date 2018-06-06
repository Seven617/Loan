//
//  ScrollActionView.h
//  ScrollAction
//
//  Created by 我来修修——developer on 2018/4/17.
//  Copyright © 2018年 SG-XR. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ScrollActionViewDelegate <NSObject>
- (void)actionToPlatWithIndex:(NSInteger)index;
@end

@interface ScrollActionButtonView: UIButton
@end

@interface ScrollActionView : UIView
@property (nonatomic,weak)id<ScrollActionViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame
//@property(nonatomic,strong)NSArray *array;
//@property(nonatomic,strong)NSArray *iconArray;
    WithSourceArray:(NSArray *)array
      WithIconArray:(NSArray *)iconArray;
@end
