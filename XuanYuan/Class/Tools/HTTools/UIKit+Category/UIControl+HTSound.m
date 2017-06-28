//
//  UIControl+HTSound.m
//  pangu
//
//  Created by King on 2017/6/15.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UIControl+HTSound.h"
#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>

static char const * const ht_kSoundsKey = "ht_kSoundsKey";

@implementation UIControl (HTSound)

- (void)ht_setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent
{
    // Remove the old UI sound.
    NSString *oldSoundKey = [NSString stringWithFormat:@"%lu", controlEvent];
    AVAudioPlayer *oldSound = [self ht_sounds][oldSoundKey];
    [self removeTarget:oldSound action:@selector(play) forControlEvents:controlEvent];
    
    // Set appropriate category for UI sounds.
    // Do not mute other playing audio.
    [[AVAudioSession sharedInstance] setCategory:@"AVAudioSessionCategoryAmbient" error:nil];
    
    // Find the sound file.
    NSString *file = [name stringByDeletingPathExtension];
    NSString *extension = [name pathExtension];
    NSURL *soundFileURL = [[NSBundle mainBundle] URLForResource:file withExtension:extension];
    
    NSError *error = nil;
    
    // Create and prepare the sound.
    AVAudioPlayer *tapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
    NSString *controlEventKey = [NSString stringWithFormat:@"%lu", controlEvent];
    NSMutableDictionary *sounds = [self ht_sounds];
    [sounds setObject:tapSound forKey:controlEventKey];
    [tapSound prepareToPlay];
    if (!tapSound) {
        NSLog(@"Couldn't add sound - error: %@", error);
        return;
    }
    
    // Play the sound for the control event.
    [self addTarget:tapSound action:@selector(play) forControlEvents:controlEvent];
}


#pragma mark - Associated objects setters/getters

- (void)setHt_sounds:(NSMutableDictionary *)sounds
{
    objc_setAssociatedObject(self, ht_kSoundsKey, sounds, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)ht_sounds
{
    NSMutableDictionary *sounds = objc_getAssociatedObject(self, ht_kSoundsKey);
    
    // If sounds is not yet created, create it.
    if (!sounds) {
        sounds = [[NSMutableDictionary alloc] initWithCapacity:2];
        // Save it for later.
        [self setHt_sounds:sounds];
    }
    
    return sounds;
}






#define HT_UICONTROL_EVENT(methodName, eventName)                                \
-(void)methodName : (void (^)(void))eventBlock {                              \
objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);\
[self addTarget:self                                                        \
action:@selector(methodName##Action:)                                       \
forControlEvents:UIControlEvent##eventName];                                \
}                                                                               \
-(void)methodName##Action:(id)sender {                                        \
void (^block)() = objc_getAssociatedObject(self, @selector(methodName:));  \
if (block) {                                                                \
block();                                                                \
}                                                                           \
}

HT_UICONTROL_EVENT(ht_touchDown, TouchDown)
HT_UICONTROL_EVENT(ht_touchDownRepeat, TouchDownRepeat)
HT_UICONTROL_EVENT(ht_touchDragInside, TouchDragInside)
HT_UICONTROL_EVENT(ht_touchDragOutside, TouchDragOutside)
HT_UICONTROL_EVENT(ht_touchDragEnter, TouchDragEnter)
HT_UICONTROL_EVENT(ht_touchDragExit, TouchDragExit)
HT_UICONTROL_EVENT(ht_touchUpInside, TouchUpInside)
HT_UICONTROL_EVENT(ht_touchUpOutside, TouchUpOutside)
HT_UICONTROL_EVENT(ht_touchCancel, TouchCancel)
HT_UICONTROL_EVENT(ht_valueChanged, ValueChanged)
HT_UICONTROL_EVENT(ht_editingDidBegin, EditingDidBegin)
HT_UICONTROL_EVENT(ht_editingChanged, EditingChanged)
HT_UICONTROL_EVENT(ht_editingDidEnd, EditingDidEnd)
HT_UICONTROL_EVENT(ht_editingDidEndOnExit, EditingDidEndOnExit)









@end
