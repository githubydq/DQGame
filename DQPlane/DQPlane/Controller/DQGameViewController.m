//
//  DQGameViewController.m
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQGameViewController.h"
#import "DQEndViewController.h"
#import "DQAudioPlayer.h"
#import "DQBackAVAudioPlayer.h"

#import "DQPlaneView.h"
#import "DQPlaneBulletView.h"

#import "DQEnemyView.h"
#import "DQEnemyBulletView.h"

#import <CoreMotion/CoreMotion.h>

@interface DQGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mark;
@property (weak, nonatomic) IBOutlet UILabel *heart;
@property (weak, nonatomic) IBOutlet UILabel *bomb;

@property(nonatomic,strong)DQPlaneView * plane;
@property(nonatomic,strong)NSMutableArray * planeBulletArray;

@property(nonatomic,strong)NSMutableArray * enemyArray;
@property(nonatomic,assign)CGFloat enemyWidth;
@property(nonatomic,strong)NSMutableArray * enemyBulletArray;

@property(nonatomic,strong)NSTimer * timer;

//CoreMotion
@property(nonatomic,strong)CMMotionManager * cmManager;
@end

@implementation DQGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.enemyWidth = 30;
    self.mark.text = @"0";
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    [self configUI];
    [self configCM];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [[DQBackAVAudioPlayer player] playWithName:@"game.wav"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[DQBackAVAudioPlayer player] stop];
}

-(NSMutableArray *)planeBulletArray{
    if (!_planeBulletArray) {
        _planeBulletArray = [[NSMutableArray alloc] init];
    }
    return _planeBulletArray;
}
-(NSMutableArray *)enemyArray{
    if (!_enemyArray) {
        _enemyArray = [[NSMutableArray alloc] init];
    }
    return _enemyArray;
}
-(NSMutableArray *)enemyBulletArray{
    if (!_enemyBulletArray) {
        _enemyBulletArray = [[NSMutableArray alloc] init];
    }
    return _enemyBulletArray;
}

#pragma mark -
#pragma mark config UI
-(void)configUI{
    self.view.backgroundColor = BACK_COLOR;
    
    self.plane = [DQPlaneView plane];
    self.plane.frame = CGRectMake((SCREEN_WIDTH-50)/2.0, SCREEN_HEIGHT-50-60, 50, 50);
    [self.view addSubview:self.plane];
    self.plane.isGame = YES;
    
    self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(gameTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bombTapClick)];
    [self.bomb addGestureRecognizer:tap];
    self.bomb.userInteractionEnabled = YES;
}
-(void)bombTapClick{
    if (self.bomb.text.length > 0) {
        self.bomb.text = [self.bomb.text substringToIndex:self.bomb.text.length-2];
        for (DQEnemyView * enemy in self.enemyArray) {
            if (enemy.state == EnemyStateRun) {
                enemy.state = EnemyStateDestroying;
                [DQAudioPlayer playWithName:@"boom.wav"];
                NSInteger mark = [self.mark.text integerValue];
                mark += 10;
                self.mark.text = [NSString stringWithFormat:@"%ld",mark];
            }
        }
    }
}


#pragma mark -
#pragma mark timer
-(void)gameTimer{
    static NSInteger num = 0;
    
    
    //飞机
    if (num % 3 == 0) {
        [self judgePlaneBullet];
    }
    [self planeBulletHit];
    
    //敌机
    if (num % 10 == 0) {
        [self enemyAdd];
    }
    [self enemyRun];
    //碰撞判断
    [self judgeBoom];
    
    //计数
    num++;
    if (num >= 100*3) {
        num = 0;
    }
}

#pragma mark -
#pragma mark 飞机的子弹

//飞机子弹判断
-(void)judgePlaneBullet{
    [DQAudioPlayer playWithName:@"shot2.wav"];
    BOOL canHit = NO;
    //是否有子弹
    for (DQPlaneBulletView * planeBullet in self.planeBulletArray) {
        if (planeBullet.state == PlaneBulletStateEnd || planeBullet.state == PlaneBulletStateHit) {
            planeBullet.center = CGPointMake(self.plane.center.x, self.plane.frame.origin.y);
            planeBullet.bounds = CGRectMake(0, 0, 5, 5);
            planeBullet.state = PlaneBulletStateRun;
            canHit = YES;
            break;
        }
    }
    //无子弹，添加子弹
    if (!canHit) {
        DQPlaneBulletView * planeBullet = [DQPlaneBulletView planeBullet];
        planeBullet.center = CGPointMake(self.plane.center.x, self.plane.frame.origin.y);
        planeBullet.bounds = CGRectMake(0, 0, 5, 5);
        planeBullet.state = PlaneBulletStateRun;
        [self.view addSubview:planeBullet];
        [self.planeBulletArray addObject:planeBullet];
    }
}
//飞机子弹射击
-(void)planeBulletHit{
    //子弹飞行
    for (DQPlaneBulletView * bullet in self.planeBulletArray) {
        if (bullet.state == PlaneBulletStateRun) {
            [UIView animateWithDuration:0.09 animations:^{
                CGRect frame = bullet.frame;
                frame.origin.y -= bullet.speed;
                bullet.frame = frame;
            }];
        }
    }
    //子弹回收
    for (DQPlaneBulletView * bullet in self.planeBulletArray) {
        if (bullet.state == PlaneBulletStateHit || bullet.frame.origin.y + bullet.frame.size.height < 0) {
            bullet.state = PlaneBulletStateEnd;
        }
    }
}

#pragma mark -
#pragma mark 敌机和子弹
-(void)enemyRun{
    for (DQEnemyView * enemy in self.enemyArray) {
        //运行
        if (enemy.state == EnemyStateRun) {
            [UIView animateWithDuration:0.1 animations:^{
                CGRect frame = enemy.frame;
                frame.origin.y += enemy.speed;
                enemy.frame = frame;
            }];
        }
        //回收
        if (enemy.frame.origin.y > SCREEN_HEIGHT) {
            enemy.state = EnemyStateEnd;
        }
    }
    
}
-(void)enemyAdd{
    BOOL haveEnemy = NO;
    //敌机的添加
    for (DQEnemyView * enemy in self.enemyArray) {
        if (enemy.state == EnemyStateEnd || enemy.state == EnemyStateDestroyed) {
            enemy.transform = CGAffineTransformMakeScale(1.0, 1.0);
            enemy.center = CGPointMake((self.enemyWidth/2.0 + arc4random()%(NSInteger)(SCREEN_WIDTH -self.enemyWidth)), -self.enemyWidth);
            enemy.state = EnemyStateRun;
            haveEnemy = YES;
            break;
        }
    }
    if (!haveEnemy) {
        DQEnemyView * enemy = [DQEnemyView enemy];
        [self.view addSubview:enemy];
        enemy.bounds = CGRectMake(0, 0, self.enemyWidth, self.enemyWidth);
        enemy.center = CGPointMake((self.enemyWidth/2.0 + arc4random()%(NSInteger)(SCREEN_WIDTH -self.enemyWidth)), -self.enemyWidth);
        [self.enemyArray addObject:enemy];
        enemy.state = EnemyStateRun;
    }
}

#pragma mark -
#pragma mark 碰撞判断
-(void)judgeBoom{
    //判断飞机子弹是否击中敌机
    for (DQPlaneBulletView * planeBullet in self.planeBulletArray) {
        if (planeBullet.state == PlaneBulletStateRun) {
            for (DQEnemyView * enemy in self.enemyArray) {
                if (enemy.state == EnemyStateRun) {
                    if (CGRectIntersectsRect(planeBullet.frame, enemy.frame)) {
                        [DQAudioPlayer playWithName:@"boom.wav"];
                        enemy.state = EnemyStateDestroying;
                        planeBullet.state = PlaneBulletStateHit;
                        NSInteger mark = [self.mark.text integerValue];
                        mark += 10;
                        self.mark.text = [NSString stringWithFormat:@"%ld",mark];
                    }
                }
            }
        }
    }
    //判断飞机是否被打到
    for (DQEnemyView * enemy in self.enemyArray) {
        if (enemy.state == EnemyStateRun) {
            if (CGRectIntersectsRect(enemy.frame, self.plane.frame)) {
                enemy.state = EnemyStateDestroying;
                [self.plane shake];
                //掉命
                if (self.heart.text.length > 2) {
                    self.heart.text = [self.heart.text substringToIndex:self.heart.text.length-2];
                    [DQAudioPlayer shake];
                }else{
                    self.heart.text = [self.heart.text substringToIndex:self.heart.text.length-2];
                    [self.timer invalidate];
                    DQEndViewController * end = [[DQEndViewController alloc] init];
                    end.markStr = self.mark.text;
                    [self.navigationController pushViewController:end animated:NO];
                }
                
            }
        }
    }
}

#pragma mark -
#pragma mark 陀螺仪传感器
-(void)configCM{
    self.cmManager = [[CMMotionManager alloc] init];
    if (self.cmManager.isGyroAvailable) {
        self.cmManager.gyroUpdateInterval = 1;
        NSOperationQueue * queue = [NSOperationQueue currentQueue];
        [self.cmManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            NSLog(@"1%@",gyroData);
            NSLog(@"2%@",error);
        }];
    }
}

@end
