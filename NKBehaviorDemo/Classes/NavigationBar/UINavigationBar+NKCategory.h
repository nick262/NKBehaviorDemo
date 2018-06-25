//
//  UINavigationBar+NKCategory.h
//  NKBehaviorDemo
//
//  Created by Nick Wang on 2018/6/22.
//  Copyright © 2018年 feeyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (NKCategory)
/**
 设置导航栏透明度

 @param transparency 透明度
 */
- (void)nk_setNavigationBarTransparency:(CGFloat)transparency;

/**
 设置导航栏背景色

 @param color 背景颜色
 */
- (void)nk_setNavigationBarBackgroundColor:(UIColor *)color;

/**
 重置导航栏
 */
- (void)nk_resetNavigationBar;

@end

