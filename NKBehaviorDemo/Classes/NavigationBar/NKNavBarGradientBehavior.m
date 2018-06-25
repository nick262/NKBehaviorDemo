//
//  NKNavBarGradientBehavior.m
//  NKBehaviorDemo
//
//  Created by Nick Wang on 2018/6/21.
//  Copyright © 2018年 feeyue. All rights reserved.
//

#import "NKNavBarGradientBehavior.h"
#import "UINavigationBar+NKCategory.h"

@implementation NKNavBarGradientBehavior{
    UIColor *_navBarOriginTintColor; //导航栏初始的tintColor
    UIColor *_navBarCurrentTintColor; //动态变化时导航栏的tintColor
    UIImage *_navBarOriginShadowImage; //导航栏的shadowImage
    UIImage *_navBarClearShadowImage;
    UIImage *_navBarCurrentShadowImage; //当前的shadowImage
    CGFloat _navBarCurrentBackgroundTransparency; //导航栏当前的透明度
    NSDictionary *_navBarOriginTitleAttribute; //导航栏初始时的titleTextAttribute
    NSMutableDictionary *_navBarCurrentTitleAttribute; //导航栏当前动态变化的titleTextAttribute
    UIStatusBarStyle _statusBarStyle;
    BOOL _didScrolled; //是否已经滚动
    BOOL _navBarDidReset; //是否恢复了导航栏的状态
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.criticalOffset         = 200;
        self.statusBarStyleChange   = YES;
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UINavigationBar *navBar = [self navigationBar];
    CGFloat offsetY = scrollView.contentOffset.y;
    
    //动态变化背景色
    _navBarCurrentBackgroundTransparency = offsetY > 0 ? scrollView.contentOffset.y / self.criticalOffset : 0;
    [navBar nk_setNavigationBarBackgroundColor:[self.barBackgroundColor colorWithAlphaComponent:_navBarCurrentBackgroundTransparency]];
    
    //导航栏不透明时，显示原本的shadowImage
    if (_navBarCurrentBackgroundTransparency > 1) {
        navBar.shadowImage = _navBarOriginShadowImage;
    }else {
        navBar.shadowImage = _navBarClearShadowImage;
    }
    _navBarCurrentShadowImage = navBar.shadowImage;
    
    if (self.statusBarStyleChange && !_navBarDidReset) {
        if (_navBarCurrentBackgroundTransparency > 0.15) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        } else {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
        
        if (!_navBarOriginTintColor) {
            _navBarOriginTintColor = navBar.tintColor;
        }
        
        _didScrolled = YES;
        // 动态变化tintColor
        if (offsetY >= 0) {
            UIColor *tintColor  = nil;
            UIColor *titleColor = nil;
            CGFloat alpha       = 1;
            
            CGFloat offset = self.criticalOffset / 2.0;
            if (offsetY < offset) {
                alpha       = 1 - offsetY / offset;
                tintColor   = [UIColor colorWithWhite:1 alpha:alpha];
                titleColor  = tintColor;
            }else {
                alpha       = offsetY / offset - 1;
                tintColor   = [_navBarOriginTintColor colorWithAlphaComponent:alpha];
                titleColor  = tintColor;
                
                UIColor *originTitleColor = _navBarOriginTitleAttribute[NSForegroundColorAttributeName];
                if (originTitleColor) {
                    titleColor = [originTitleColor colorWithAlphaComponent:alpha];
                }
            }
            navBar.tintColor = tintColor;
            _navBarCurrentTintColor = tintColor;
            _navBarCurrentTitleAttribute[NSForegroundColorAttributeName] = titleColor;
            navBar.titleTextAttributes = _navBarCurrentTitleAttribute;
        }
    }
}
- (void)onViewWillAppear{
    [self initializeOrRecover];
}
- (void)onViewWillDisAppear{
    [self reset];
}
/**
 存储导航栏初始时状态

 @param navBar UINavigationBar类型对象
 */
- (void)storeNaviBarAppearance:(UINavigationBar *)navBar {
    _navBarOriginTintColor      = navBar.tintColor;
    _navBarOriginTitleAttribute = navBar.titleTextAttributes;
    _statusBarStyle             = [UIApplication sharedApplication].statusBarStyle;
    _navBarOriginShadowImage    = navBar.shadowImage;
}

/**
 恢复导航栏的状态到初始时的状态

 @param navBar UINavigationBar类型对象
 */
- (void)restoreNavigationBarAppearance:(UINavigationBar *)navBar{
    navBar.tintColor           = _navBarOriginTintColor;
    navBar.titleTextAttributes = _navBarOriginTitleAttribute;
    [navBar nk_resetNavigationBar];
    [[UIApplication sharedApplication] setStatusBarStyle:_statusBarStyle];
}

/**
 初始化状态
 */
- (void)initialize{
    UINavigationBar *navBar     = [self navigationBar];
    _navBarDidReset             = NO;
    
    [self storeNaviBarAppearance:navBar];
    
    [navBar nk_setNavigationBarTransparency:0];
    _navBarClearShadowImage     = [UIImage new];
    navBar.shadowImage          = _navBarClearShadowImage;
    
    UIColor *whiteColor         = [UIColor whiteColor];
    navBar.tintColor            = whiteColor;
    
    _navBarCurrentTitleAttribute = [_navBarOriginTitleAttribute mutableCopy];
    if (!_navBarCurrentTitleAttribute) {
        _navBarCurrentTitleAttribute = [NSMutableDictionary dictionary];
    }
    _navBarCurrentTitleAttribute[NSForegroundColorAttributeName] = whiteColor;
    navBar.titleTextAttributes = _navBarCurrentTitleAttribute;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}
/**
 恢复状态，恢复到之前重置的状态
 */
- (void)recover {
    UINavigationBar *navBar = [self navigationBar];
    
    if (_navBarCurrentTintColor) {
        navBar.tintColor = _navBarCurrentTintColor;
    }
    
    navBar.titleTextAttributes = _navBarCurrentTitleAttribute;
    [navBar nk_setNavigationBarBackgroundColor:[self.barBackgroundColor colorWithAlphaComponent:_navBarCurrentBackgroundTransparency]];
    navBar.shadowImage = _navBarCurrentShadowImage;
    
}


/**
 根据当前状态自动调用initialize或者recover方法
 */
- (void)initializeOrRecover{
    if (_didScrolled) {
        [self recover];
    } else {
        [self initialize];
    }
}
/**
 重置状态，回到初始化时的状态，在Controller的ViewWillDisAppear中调用。
 */
- (void)reset{
    _navBarDidReset = YES;
    UINavigationBar *navBar = [self navigationBar];
    [self restoreNavigationBarAppearance:navBar];
}



- (UINavigationBar *)navigationBar{
    return ((UIViewController *)self.owner).navigationController.navigationBar;
}
- (UIColor *)barBackgroundColor{
    if (!_barBackgroundColor) {
        UINavigationBar *navBar = [self navigationBar];
        if (navBar.barTintColor) {
            _barBackgroundColor = navBar.barTintColor ;
        }else{
            _barBackgroundColor = [UIColor whiteColor];
        }
        
    }
    return  _barBackgroundColor;
}


@end
