//
//  NKCharacterLimitBehavior.m
//  NKBehaviorDemo
//
//  Created by Nick Wang on 2018/6/21.
//  Copyright © 2018年 feeyue. All rights reserved.
//

#import "NKTextViewLimitBehavior.h"

@implementation NKTextViewLimitBehavior
- (void)updateCharacterLimit:(NSString *)text{
    self.countLabel.text = [NSString stringWithFormat:@"%@/%@",@(text.length),@(_maxCount)];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (self.hideKeyboardOnReturn && [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location != NSNotFound) {
        [textView resignFirstResponder];
        return NO;
    }
    UITextRange *selectedRange = [textView markedTextRange];
    if (selectedRange) {
        return YES;
    }
    NSString *modifiedText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    const BOOL willModifyText = modifiedText.length <= self.maxCount;
    if (willModifyText) {
        [self updateCharacterLimit:modifiedText];
    }
    return willModifyText;
}
- (void)textViewDidChange:(UITextView *)textView{
    UITextRange *selectedRange = [textView markedTextRange];
    if (selectedRange) {
        return;
    }
    if (textView.text.length > self.maxCount) {
        NSString *text = textView.text;
        BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
        if (asc) {
            self.textView.text = [text substringFromIndex:self.maxCount];
        }else{
            // emoji表情会占用两个长度
            __block NSInteger idx = 0;
            [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                     options:NSStringEnumerationByComposedCharacterSequences
                                  usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                                      if (idx + substring.length > self.maxCount) {
                                          *stop = YES;
                                          return ;
                                      }
                                      idx += substring.length;
                                  }];
            textView.text = [textView.text substringToIndex:idx];
        }
    }
    [self updateCharacterLimit:textView.text];
}
#pragma mark - Getters & Setters
- (void)setTextView:(UITextView *)textView {
    _textView = textView;
    [self updateCharacterLimit:self.textView.text];
}
- (void)setCounterLabel:(UILabel *)counterLabel {
    _countLabel = counterLabel;
    [self updateCharacterLimit:self.textView.text];
}
@end
