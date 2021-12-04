//
//  RMFpsLabel.m
//  RMLog_Example
//
//  Created by yangche on 2019/8/13.
//  Copyright © 2019 春节. All rights reserved.
//

#import "RMFpsLabel.h"

@interface RMFpsLabel ()
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) int count;
@end

@implementation RMFpsLabel

- (void)didMoveToSuperview {
    self.frame = CGRectMake(15, 5, 80, 20);
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor blackColor];
    self.textColor = [UIColor greenColor];
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:14];
    [self run];
}

- (void)run {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)tick:(CADisplayLink *)sender {
    if (_lastTime == 0) {
        _lastTime = _displayLink.timestamp;
        return;
    }
    _count += 1;
    NSTimeInterval timeDelta = _displayLink.timestamp - _lastTime;
    if (timeDelta < 0.25) {
        return;
    }
    _lastTime = _displayLink.timestamp;
    double fps = (double)_count / timeDelta;
    _count = 0;
    self.text = [NSString stringWithFormat:@"FPS:%.1f",fps];
    self.textColor = fps > 50 ? UIColor.greenColor : UIColor.redColor;
}

@end
