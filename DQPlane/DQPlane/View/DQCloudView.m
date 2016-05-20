//
//  DQCloudView.m
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQCloudView.h"

@implementation DQCloudView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = BACK_COLOR;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    NSString * path = [NSString stringWithFormat:@"%@/cloud",IMAGE_PATH];
    UIImage * image = [UIImage imageWithContentsOfFile:path];
    [image drawInRect:rect];
}

@end
