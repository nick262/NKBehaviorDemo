//
//  UINavigationBar+NKCategory.m
//  NKBehaviorDemo
//
//  Created by Nick Wang on 2018/6/22.
//  Copyright © 2018年 feeyue. All rights reserved.
//

#import "UINavigationBar+NKCategory.h"
#import <objc/runtime.h>
@interface UINavigationBar ()

@property (nonatomic,assign) BOOL nkOriginIsTranslucent;
@property (nonatomic,strong) UIImage *nkOriginBackgroundImage;
@property (nonatomic,strong) UIImage *nkOriginShadowImage;
@property (nonatomic,strong) UIView *nkBackgroundView;
@end
@implementation UINavigationBar (NKCategory)

- (void)nk_setNavigationBarTransparency:(CGFloat)transparency{
    [self nk_setNavigationBarBackgroundColor:[self.barTintColor colorWithAlphaComponent:transparency]];
}
- (void)nk_setNavigationBarBackgroundColor:(UIColor *)color{
    if (!self.nkBackgroundView) {
        self.nkOriginBackgroundImage = [self backgroundImageForBarMetrics:UIBarMetricsDefault];
        self.nkOriginShadowImage = self.shadowImage;
        self.nkOriginIsTranslucent = self.translucent;
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:nil];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 20)];
        bgView.userInteractionEnabled = NO;
        [self insertSubview:bgView atIndex:0];
        self.nkBackgroundView = bgView;
        self.translucent = YES;
    }
    self.nkBackgroundView.backgroundColor = color;
}
- (void)nk_resetNavigationBar {
    [self setBackgroundImage:self.nkOriginBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:self.nkOriginShadowImage];
    [self setTranslucent:self.nkOriginIsTranslucent];
    [self.nkBackgroundView removeFromSuperview];
    self.nkOriginBackgroundImage = nil;
    self.nkOriginShadowImage = nil;
    self.nkBackgroundView = nil;
}
#pragma mark - getters & setters
-(UIImage *)nkOriginBackgroundImage {
    return objc_getAssociatedObject(self, @selector(nkOriginBackgroundImage));
}
-(void)setNkOriginBackgroundImage:(UIImage *)nkOriginBackgroundImage{
    objc_setAssociatedObject(self, @selector(nkOriginBackgroundImage),nkOriginBackgroundImage,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImage *)nkOriginShadowImage{
    return objc_getAssociatedObject(self, @selector(nkOriginShadowImage));
}
-(void)setNkOriginShadowImage:(UIImage *)nkOriginShadowImage{
    objc_setAssociatedObject(self, @selector(nkOriginShadowImage), nkOriginShadowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)nkBackgroundView{
    return objc_getAssociatedObject(self, @selector(nkBackgroundView));
}
-(void)setNkBackgroundView:(UIView *)nkBackgroundView{
    objc_setAssociatedObject(self, @selector(nkBackgroundView), nkBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)nkOriginIsTranslucent{
    return [objc_getAssociatedObject(self, @selector(nkOriginIsTranslucent)) boolValue];
}
-(void)setNkOriginIsTranslucent:(BOOL)nkOriginIsTranslucent{
    objc_setAssociatedObject(self, @selector(nkOriginIsTranslucent), @(nkOriginIsTranslucent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end










