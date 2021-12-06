//
//  TJUpdateView.m
//  iOSShard
//
//  Created by 任春节 on 2021/12/6.
//

#import "TJUpdateView.h"
#import <Masonry/Masonry.h>

@interface TJUpdateView ()
/// 第一视图
@property(nonatomic,strong)  UIView *oneView;
/// 第二视图
@property(nonatomic,strong)  UIView *twoView;
@end
@implementation TJUpdateView

- (instancetype)init{
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    [self addSubview:({
        _oneView = [[UIView alloc] init];
        _oneView.backgroundColor = UIColor.redColor;
        _oneView;
    })];
    [self addSubview:({
        _twoView = [[UIView alloc] init];
        _twoView.backgroundColor = UIColor.yellowColor;
        _twoView;
    })];
}

-(void)updateConstraints{
    [super updateConstraints];
//    _oneView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2);
//    _twoView.frame = CGRectMake(0, CGRectGetHeight(self.frame) / 2, CGRectGetWidth(self.frame),  CGRectGetHeight(self.frame) / 2);
    [_oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(@0);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
    }];
    [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(@0);
        make.top.mas_equalTo(self.oneView.mas_bottom);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
        
    }];
    NSLog(@"%@我是_oneView位置",[NSValue valueWithCGRect:_oneView.frame]);
    NSLog(@"%@我是_twoView位置",[NSValue valueWithCGRect:_twoView.frame]);
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    NSLog(@"我来了 -%s",__func__);
    NSLog(@"%@",[NSValue valueWithCGRect:self.frame]);
}
-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    NSLog(@"我来了 -%s",__func__);
    NSLog(@"%@",[NSValue valueWithCGRect:self.frame]);
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    NSLog(@"我来了 -%s",__func__);
    NSLog(@"%@",[NSValue valueWithCGRect:self.frame]);
}
-(void)didMoveToWindow{
    [super didMoveToWindow];
    NSLog(@"我来了 -%s",__func__);
    NSLog(@"%@",[NSValue valueWithCGRect:self.frame]);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"我来了 -%s",__func__);
    NSLog(@"%@",[NSValue valueWithCGRect:self.frame]);
}

@end
