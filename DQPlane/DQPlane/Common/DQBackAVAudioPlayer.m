//
//  DQBackAVAudioPlayer.m
//  DQPlane
//
//  Created by youdingquan on 16/5/16.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQBackAVAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface DQBackAVAudioPlayer ()
@property(nonatomic,strong)AVAudioPlayer * player;
@end

@implementation DQBackAVAudioPlayer

+(instancetype)player{
    static DQBackAVAudioPlayer * back = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        back = [[DQBackAVAudioPlayer alloc] init];
    });
    return back;
}

-(void)playWithName:(NSString *)name{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:MY_BGAV] integerValue]) {
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",MUSIC_PATH, name]] error:nil];
        self.player.numberOfLoops = -1;
        [self.player prepareToPlay];
        [self.player play];
    }
}

-(void)stop{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:MY_BGAV] integerValue]) {
        [self.player stop];
    }
}

@end
