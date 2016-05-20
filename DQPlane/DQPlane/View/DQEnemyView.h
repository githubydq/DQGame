//
//  DQEnemyView.h
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, EnemyState) {
    EnemyStateRun = 0,
    EnemyStateDestroyed,
    EnemyStateDestroying,
    EnemyStateEnd
};

@interface DQEnemyView : UIView
@property(nonatomic,assign)CGFloat speed;
@property(nonatomic,assign)EnemyState state;

+(instancetype)enemy;
@end
