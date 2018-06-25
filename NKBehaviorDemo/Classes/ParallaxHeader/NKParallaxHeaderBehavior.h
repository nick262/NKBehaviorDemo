//
//  NKParallaxHeaderBehavior.h
//  NKBehaviorDemo
//
//  Created by Nick Wang on 2018/6/21.
//  Copyright © 2018年 feeyue. All rights reserved.
//

#import "NKBehavior.h"

@interface NKParallaxHeaderBehavior : NKBehavior<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *targetView;
/*  向上滚动时，背景与scrollview offsetY的视差倍率，默认0.6  */
@property (nonatomic, assign) IBInspectable CGFloat offsetMultiple;

@end
