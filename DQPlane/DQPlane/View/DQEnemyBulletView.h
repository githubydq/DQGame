//
//  DQEnemyBulletView.h
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EnemyBulletState) {
    EnemyBulletStateRun = 0,
    EnemyBulletStateHit,
    EnemyBulletStateEnd
};

@interface DQEnemyBulletView : UIView
+(instancetype)enemyBullet;

@property(nonatomic,assign)EnemyBulletState state;
@property(nonatomic,assign)CGFloat speed;
@end
