//
//  DQEnemyBulletView.m
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQEnemyBulletView.h"

@implementation DQEnemyBulletView

+(instancetype)enemyBullet{
    DQEnemyBulletView * bullet = [[super alloc] init];
    if (bullet) {
        bullet.backgroundColor = [UIColor clearColor];
        bullet.speed = 20;
    }
    return bullet;
}

- (void)drawRect:(CGRect)rect {
    [[UIColor redColor] setFill];
    UIBezierPath * bezier = [UIBezierPath bezierPathWithOvalInRect:rect];
    [bezier fill];
}
@end
