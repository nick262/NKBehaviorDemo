//
//  NKCharacterLimitBehavior.h
//  NKBehaviorDemo
//
//  Created by Nick Wang on 2018/6/21.
//  Copyright © 2018年 feeyue. All rights reserved.
//

#import "NKBehavior.h"

@interface NKTextViewLimitBehavior : NKBehavior<UITextViewDelegate>

@property (nonatomic, weak)  IBOutlet UITextView * textView;
@property (nonatomic, weak)  IBOutlet UILabel * countLabel;
@property (nonatomic, assign) IBInspectable NSUInteger maxCount;
@property (nonatomic, assign) IBInspectable BOOL hideKeyboardOnReturn;

@end
