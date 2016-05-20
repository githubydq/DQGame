//
//  DQEndViewController.m
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQEndViewController.h"
#import "DQBackAVAudioPlayer.h"

@interface DQEndViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mark;

@end

@implementation DQEndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACK_COLOR;
    
    self.mark.text = self.markStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    
    [[DQBackAVAudioPlayer player] playWithName:@"over.wav"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[DQBackAVAudioPlayer player] stop];
}

- (IBAction)backHome:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
