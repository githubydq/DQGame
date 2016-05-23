//
//  DQSetViewController.m
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQSetViewController.h"

@interface DQSetViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *audioSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *backAVSwitch;

@end

@implementation DQSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.audioSwitch.on = [[[NSUserDefaults standardUserDefaults] objectForKey:MY_AUDIO] integerValue] == 1 ? YES : NO;
    self.backAVSwitch.on = [[[NSUserDefaults standardUserDefaults] objectForKey:MY_BGAV] integerValue] == 1 ? YES : NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)audioSwitchClick:(UISwitch *)sender {
    NSNumber * on = sender.on ? @1:@0;
    [[NSUserDefaults standardUserDefaults] setObject:on forKey:MY_AUDIO];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)backAVSwitchClick:(UISwitch *)sender {
    NSNumber * on = sender.on ? @1:@0;
    [[NSUserDefaults standardUserDefaults] setObject:on forKey:MY_BGAV];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
