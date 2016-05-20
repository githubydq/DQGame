//
//  DQPlaneBulletView.m
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQPlaneBulletView.h"

@implementation DQPlaneBulletView

+(instancetype)planeBullet{
    DQPlaneBulletView * bullet = [[super alloc] init];
    if (bullet) {
        bullet.backgroundColor = [UIColor clearColor];
        bullet.speed = 20;
    }
    return bullet;
}

-(void)setState:(PlaneBulletState)state{
    _state = state;
    if (_state == PlaneBulletStateHit) {
        self.alpha = 0;
    }else if (_state == PlaneBulletStateRun){
        self.alpha = 1;
    }
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] setFill];
    UIBezierPath * bezier = [UIBezierPath bezierPathWithOvalInRect:rect];
    [bezier fill];
}

@end
