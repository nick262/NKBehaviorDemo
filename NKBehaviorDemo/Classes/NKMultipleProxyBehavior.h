//
//  NKMultipleProxyBehavior.h
//  NKBehaviorDemo
//
//  Created by Nick Wang on 2018/6/21.
//  Copyright © 2018年 feeyue. All rights reserved.
//

#import "NKBehavior.h"

@interface NKMultipleProxyBehavior : NKBehavior

@property (nonatomic, weak) IBOutletCollection(id) NSArray * delegateTargets;

@end
