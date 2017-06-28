//
//  UITextView+HTInputLimit.m
//  pangu
//
//  Created by King on 2017/6/14.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UITextView+HTInputLimit.h"

static const void *HTTextViewInputLimitMaxLength = &HTTextViewInputLimitMaxLength;


@implementation UITextView (HTInputLimit)


- (NSInteger)ht_maxLength {
    return [objc_getAssociatedObject(self, HTTextViewInputLimitMaxLength) integerValue];
}
- (void)setHt_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, HTTextViewInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ht_textViewTextDidChange:)
                                                name:@"UITextViewTextDidChangeNotification" object:self];
    
}
- (void)ht_textViewTextDidChange:(NSNotification *)notification {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.ht_maxLength > 0 && toBeString.length > self.ht_maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.ht_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.ht_maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.ht_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.ht_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
