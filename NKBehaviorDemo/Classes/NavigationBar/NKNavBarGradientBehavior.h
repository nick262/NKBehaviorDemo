//
//  NKNavBarGradientBehavior.h
//  NKBehaviorDemo
//
//  Created by Nick Wang on 2018/6/21.
//  Copyright © 2018年 feeyue. All rights reserved.
//

#import "NKBehavior.h"

@interface NKNavBarGradientBehavior : NKBehavior<UIScrollViewDelegate>

/*  状态栏颜色是否动态改变，默认未YES，需要在info.plist设置 View controller-based status bar apperance 为NO才有效果 */
@property (nonatomic, assign) IBInspectable BOOL statusBarStyleChange;

/*  导航栏tintColor编号的临界值默认为200  */
@property (nonatomic, assign) IBInspectable CGFloat criticalOffset;

/*  导航栏渐变时的背景颜色，默认未navigationbar.barTintColor  */
@property (nonatomic, strong) IBInspectable UIColor *barBackgroundColor;

- (void)onViewWillAppear;

- (void)onViewWillDisAppear;

@end
