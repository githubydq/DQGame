//
//  DQPlaneView.h
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DQPlaneView : UIView

@property(nonatomic,assign)BOOL isGame;

+(instancetype)plane;
/**
 震动
 */
-(void)shake;

/**
 翻转
 */
-(void)overturn;



@end
