//
//  TJXibTapController.m
//  iOSShard
//
//  Created by 任春节 on 2021/12/4.
//

#import "TJXibTapController.h"
#import "TJXibTapView.h"
#import "TJCategory.h"
@interface TJXibTapController ()
@end
@implementation TJXibTapController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        UIView *tapView = [TJXibTapView loadFromNibLast];
        tapView.frame = CGRectMake(0, self.view.navBarHighly, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - self.view.navBarHighly);
        tapView;
    })];
    // Do any additional setup after loading the view.
}



@end
