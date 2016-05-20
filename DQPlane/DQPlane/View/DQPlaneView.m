//
//  DQPlaneView.m
//  DQPlane
//
//  Created by youdingquan on 16/5/15.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "DQPlaneView.h"

@implementation DQPlaneView

+(instancetype)plane{
    DQPlaneView * plane = [[super alloc] init];
    if (plane) {
        plane.backgroundColor = [UIColor clearColor];
    }
    return plane;
}

#pragma mark -
#pragma mark delegate

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.isGame) {
        UITouch *aTouch = [touches anyObject];
        //获取当前触摸操作的位置坐标
        CGPoint loc = [aTouch locationInView:self];
        //获取上一个触摸点的位置坐标
        CGPoint prevloc = [aTouch previousLocationInView:self];
        CGRect myFrame = self.frame;
        //改变View的x、y坐标值
        float deltaX = loc.x - prevloc.x;
        float deltaY = loc.y - prevloc.y;
        myFrame.origin.x += deltaX;
        myFrame.origin.y += deltaY;
        //重新设置View的显示位置
        [self setFrame:myFrame];
    }
}

#pragma mark -
#pragma mark draw

- (void)drawRect:(CGRect)rect {
    NSString * path = [NSString stringWithFormat:@"%@/plane",IMAGE_PATH];
    UIImage * image = [UIImage imageWithContentsOfFile:path];
    [image drawInRect:rect];
}

#pragma mark -
#pragma mark

-(void)shake{
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
            self.transform = CGAffineTransformMakeTranslation(10, 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeTranslation(-10, 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    } completion:nil];
}

-(void)overturn{
    CGRect bounds = self.bounds;
    CGPoint center = self.center;
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            self.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
            self.bounds = CGRectMake(0, 0, bounds.size.width*0.5, bounds.size.height*0.5);
            self.center = CGPointMake(center.x, center.y+40);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            self.layer.transform = CATransform3DMakeRotation(2*M_PI, 0, 1, 0);
            self.bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
            self.center = CGPointMake(center.x, center.y);
        }];
    } completion:^(BOOL finished) {
        //        self.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0);
    }];
}
@end
