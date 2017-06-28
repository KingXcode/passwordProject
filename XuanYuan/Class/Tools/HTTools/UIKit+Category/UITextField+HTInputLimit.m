//
//  UITextField+HTInputLimit.m
//  pangu
//
//  Created by King on 2017/6/14.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UITextField+HTInputLimit.h"


static const void *HTTextFieldInputLimitMaxLength = &HTTextFieldInputLimitMaxLength;

@implementation UITextField (HTInputLimit)
- (NSInteger)ht_maxLength {
    return [objc_getAssociatedObject(self, HTTextFieldInputLimitMaxLength) integerValue];
}
- (void)setHt_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, HTTextFieldInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(jk_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)jk_textFieldTextDidChange {
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
@end
