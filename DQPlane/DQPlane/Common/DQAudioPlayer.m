//
//  DQAudioPlayer.m
//  DQPlane
//
//  Created by youdingquan on 16/5/16.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQAudioPlayer.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation DQAudioPlayer
+(void)playWithName:(NSString *)name{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:MY_AUDIO] integerValue]) {
        SystemSoundID soundID;
        NSString *soundFile = [NSString stringWithFormat:@"%@/%@",MUSIC_PATH,name];
        //一个指向文件位置的CFURLRef对象和一个指向要设置的SystemSoundID变量的指针
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
        AudioServicesPlaySystemSound(soundID);
    }
}

+(void)shake{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:MY_AUDIO] integerValue]) {
        SystemSoundID soundID;
        NSString *soundFile = [NSString stringWithFormat:@"%@/boom.wav",MUSIC_PATH];
        //一个指向文件位置的CFURLRef对象和一个指向要设置的SystemSoundID变量的指针
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
        AudioServicesPlayAlertSound(soundID);
    }
}
@end
