//
//  NKParallaxHeaderBehavior.m
//  NKBehaviorDemo
//
//  Created by Nick Wang on 2018/6/21.
//  Copyright © 2018年 feeyue. All rights reserved.
//

#import "NKParallaxHeaderBehavior.h"

#define defaultOffsetMultiple 0.6

@interface NKParallaxHeaderBehavior ()

@property (nonatomic, assign) CGRect targetViewOriginFrame;

@end

@implementation NKParallaxHeaderBehavior{
    BOOL _didInited;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!_didInited) {
        _targetViewOriginFrame = self.targetView.frame;
        _didInited = YES;
        if (_offsetMultiple > 1 || _offsetMultiple <=0) {
            _offsetMultiple = defaultOffsetMultiple;
        }
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0) {
        //向上滚动
        CGFloat increment = offsetY * _offsetMultiple;
        self.targetView.frame = CGRectMake(_targetViewOriginFrame.origin.x,
                                           _targetViewOriginFrame.origin.y - increment,
                                           _targetViewOriginFrame.size.width,
                                           _targetViewOriginFrame.size.height);
    }else{
        //向下滚动
        CGFloat height = _targetViewOriginFrame.size.height +ABS(offsetY);
        CGFloat width = height * _targetViewOriginFrame.size.width / _targetViewOriginFrame.size.height;
        CGFloat x = _targetViewOriginFrame.origin.x - (width - _targetViewOriginFrame.size.width) / 2.0;
        self.targetView.frame = CGRectMake(x, _targetViewOriginFrame.origin.y, width, height);
    }
}
- (void)setOffsetMultiple:(CGFloat)offsetMultiple{
    if (offsetMultiple > 1 || offsetMultiple <= 0) {
        _offsetMultiple = defaultOffsetMultiple;
    }else{
        _offsetMultiple = offsetMultiple;
    }
}
@end
