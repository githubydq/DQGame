//
//  DQWelcomeViewController.m
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQWelcomeViewController.h"
#import "DQGameViewController.h"
#import "DQSetViewController.h"

#import "DQAudioPlayer.h"
#import "DQBackAVAudioPlayer.h"

#import "DQPlaneView.h"
#import "DQCloudView.h"

@interface DQWelcomeViewController ()
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong)DQPlaneView * plane;

@property (weak, nonatomic) IBOutlet UIButton *start;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startHeight;
@property (weak, nonatomic) IBOutlet UIButton *set;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *setHeight;

@end

@implementation DQWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = BACK_COLOR;
    
    self.timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(welcomeTimerRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.timer setFireDate:[NSDate distantPast]];
    [self cloudAnimation];
    
    [[DQBackAVAudioPlayer player] playWithName:@"welcome.wav"];
//    [DQAudioPlayer playWithName:@"welcome.wav"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[DQBackAVAudioPlayer player] stop];
    [self.timer setFireDate:[NSDate distantFuture]];
//    self.timer = nil;
}

-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}


#pragma mark -
#pragma mark configUI
-(void)configUI{
    DQPlaneView * plane = [DQPlaneView plane];
    plane.frame = CGRectMake((SCREEN_WIDTH-100)/2.0, (SCREEN_HEIGHT-100)/2.0, 100, 100);
    plane.backgroundColor = [UIColor clearColor];
    [self.view addSubview:plane];
    self.plane = plane;
    self.plane.isGame = NO;
    
    self.start.layer.cornerRadius = self.startHeight.constant/2.0;
    self.start.layer.masksToBounds = YES;
    self.start.layer.borderWidth = 2;
    self.start.layer.borderColor = [UIColor whiteColor].CGColor;
    self.set.layer.cornerRadius = self.setHeight.constant/2.0;
    self.set.layer.masksToBounds = YES;
    self.set.layer.borderWidth = 2;
    self.set.layer.borderColor = [UIColor whiteColor].CGColor;
}

#pragma mark -
#pragma mark animation
-(void)cloudAnimation{
    DQCloudView * cloud1 = [[DQCloudView alloc] init];
    cloud1.frame = CGRectMake(30, -50, 100, 50);
    [self.view addSubview:cloud1];
    DQCloudView * cloud2 = [[DQCloudView alloc] init];
    cloud2.frame = CGRectMake(SCREEN_WIDTH-100-30, -50, 100, 50);
    [self.view addSubview:cloud2];
    //置于底层
    [self.view insertSubview:cloud1 atIndex:0];
    [self.view insertSubview:cloud2 atIndex:0];    //动画
    [UIView animateWithDuration:9 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionRepeat animations:^{
        cloud1.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT+50);
    } completion:^(BOOL finished) {
        cloud1.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    [UIView animateWithDuration:9 delay:4.5 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionRepeat animations:^{
        cloud2.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT+50);
    } completion:^(BOOL finished) {
        cloud2.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

#pragma mark -
#pragma mark timer run
-(void)welcomeTimerRun{
    static NSInteger num = 0;
    
    if (num % (3*2) == 0) {
        [self.plane overturn];
    }
    
    num++;
    if (num == 100*6) {
        num = 0;
    }
}

#pragma mark -
#pragma mark click

- (IBAction)begin:(UIButton *)sender {
    DQGameViewController * game = [[DQGameViewController alloc] init];
    [self.navigationController pushViewController:game animated:NO];
    [DQAudioPlayer playWithName:@"start.wav"];
}

- (IBAction)set:(UIButton *)sender {
    DQSetViewController * set = [[DQSetViewController alloc] init];
    set.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
    [set.navigationItem.backBarButtonItem setTitle:@"饭"];
    [self.navigationController pushViewController:set animated:NO];
}

@end
