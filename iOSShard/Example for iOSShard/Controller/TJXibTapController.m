//
//  TJXibTapController.m
//  iOSShard
//
//  Created by 任春节 on 2021/12/4.
//

#import "TJXibTapController.h"
#import "TJXibTapView.h"
#import "TJCategory.h"
#import "TJUpdateView.h"
#import <Masonry/Masonry.h>

@interface TJXibTapController ()
///
@property(nonatomic,strong)  TJUpdateView *updateView;

///
@property(nonatomic,strong)  TJXibTapView *tapView;
@end
@implementation TJXibTapController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

/// 布局
- (void)setupView{
    [self.view addSubview:({
        _tapView = [TJXibTapView loadFromNibLast];
        _tapView.frame = CGRectMake(0, self.view.navBarHighly, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - self.view.navBarHighly);
        _tapView;
    })];
    [self.view addSubview:({
        _updateView = [[TJUpdateView alloc] init];
        _updateView.backgroundColor = UIColor.blueColor;
        _updateView;
    })];
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_updateLoaction:)];
    [_updateView addGestureRecognizer:longGesture];
    [self.view addSubview:_updateView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapUpdateLoaction:)];
    [_updateView addGestureRecognizer:tap];
    [_updateView addGestureRecognizer:tap];
    

    
}
// 添加视图是否会调用
- (void)updateViewConstraints{
    [super updateViewConstraints];
    NSLog(@"%@我是_tapView位置",[NSValue valueWithCGRect:_tapView.frame]);
    NSLog(@"%@我是_updateView位置",[NSValue valueWithCGRect:_updateView.frame]);
    _updateView.frame = CGRectMake(CGRectGetMinX(_tapView.frame), 300, 100, 200);
}

- (void)_updateLoaction:(UILongPressGestureRecognizer *)gesture{
    _updateView.center = [gesture locationInView:_updateView.superview];
    CGRect frame = _updateView.frame;
    frame.size.width += 5;
    frame.size.height += 5;
    _updateView.frame = frame;
    [_updateView setNeedsUpdateConstraints];
}

- (void)_tapUpdateLoaction:(UILongPressGestureRecognizer *)gesture{
    [_updateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [_updateView setNeedsUpdateConstraints];
}

@end
