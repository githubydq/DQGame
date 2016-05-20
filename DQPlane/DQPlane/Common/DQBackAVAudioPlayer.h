//
//  DQBackAVAudioPlayer.h
//  DQPlane
//
//  Created by youdingquan on 16/5/16.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQBackAVAudioPlayer : NSObject

+(instancetype)player;

-(void)playWithName:(NSString*)name;
-(void)stop;

@end
