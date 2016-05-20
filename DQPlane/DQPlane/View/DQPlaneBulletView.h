//
//  DQPlaneBulletView.h
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PlaneBulletState) {
    PlaneBulletStateRun = 0,
    PlaneBulletStateHit,
    PlaneBulletStateEnd
};

@interface DQPlaneBulletView : UIView
+(instancetype)planeBullet;

@property(nonatomic,assign)PlaneBulletState state;
@property(nonatomic,assign)CGFloat speed;
@end
