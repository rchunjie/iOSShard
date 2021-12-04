//
//  TJViewController.m
//  iOSShard
//
//  Created by 任春节 on 2021/12/4.
//

#import "TJViewController.h"
#import "TJPushDemoController.h"
#import "TJDemoDataSources.h"

@interface TJViewController ()

@end

@implementation TJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

/// 布局
- (void)setupView{
    self.navigationItem.title = @"跳转信息";
    TJPushDemoController *vc = [[TJPushDemoController alloc] init];
    [vc setValuesForKeysWithDictionary:@{@"dataSource":[TJDemoDataSources demoDataSources]}];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    vc.view.frame = self.view.bounds;
    vc.view.backgroundColor = UIColor.whiteColor;
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
