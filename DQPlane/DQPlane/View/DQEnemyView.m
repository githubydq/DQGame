//
//  DQEnemyView.m
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQEnemyView.h"

@implementation DQEnemyView

+(instancetype)enemy{
    DQEnemyView * enemy = [[super alloc] init];
    if (enemy) {
        enemy.backgroundColor = [UIColor clearColor];
        enemy.speed = 10;
    }
    return enemy;
}

-(void)setState:(EnemyState)state{
    _state = state;
    if (_state == EnemyStateDestroying) {
        [self destroyed];
    }else if (_state == EnemyStateDestroyed){
    }else if (_state == EnemyStateEnd){
        self.alpha = 0.0;
        [self.layer removeAllAnimations];
        self.center = CGPointMake(0, SCREEN_HEIGHT*2);
    }else if (_state == EnemyStateRun){
        self.alpha = 1.0;
    }
}

#pragma mark -
#pragma mark
- (void)drawRect:(CGRect)rect {
    UIImage * image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/enemy",IMAGE_PATH]];
    [image drawInRect:rect];
}



-(void)destroyed{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
        self.transform = CGAffineTransformMakeScale(2.0, 2.0);
    }completion:^(BOOL finished) {
        self.state = EnemyStateDestroyed;
    }];
}

@end
