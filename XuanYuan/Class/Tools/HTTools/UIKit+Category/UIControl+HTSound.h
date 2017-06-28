//
//  UIControl+HTSound.h
//  pangu
//
//  Created by King on 2017/6/15.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (HTSound)
//不同事件增加不同声音
- (void)ht_setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent;



- (void)ht_touchDown:(void (^)(void))eventBlock;
- (void)ht_touchDownRepeat:(void (^)(void))eventBlock;
- (void)ht_touchDragInside:(void (^)(void))eventBlock;
- (void)ht_touchDragOutside:(void (^)(void))eventBlock;
- (void)ht_touchDragEnter:(void (^)(void))eventBlock;
- (void)ht_touchDragExit:(void (^)(void))eventBlock;
- (void)ht_touchUpInside:(void (^)(void))eventBlock;
- (void)ht_touchUpOutside:(void (^)(void))eventBlock;
- (void)ht_touchCancel:(void (^)(void))eventBlock;
- (void)ht_valueChanged:(void (^)(void))eventBlock;
- (void)ht_editingDidBegin:(void (^)(void))eventBlock;
- (void)ht_editingChanged:(void (^)(void))eventBlock;
- (void)ht_editingDidEnd:(void (^)(void))eventBlock;
- (void)ht_editingDidEndOnExit:(void (^)(void))eventBlock;
@end
