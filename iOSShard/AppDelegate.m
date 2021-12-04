//
//  AppDelegate.m
//  iOSShard
//
//  Created by 任春节 on 2021/9/7.
//

#import "AppDelegate.h"
#import "TJViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 最小版本iOS 15.0
//#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 150000
//    if (@available(iOS 15.0, *)) {
//        [UITableView appearance].sectionHeaderTopPadding = 0;
//    }
//#endif
//
//    // 最大版本 iOS 15.0
//#if __IPHONE_OS_VERSION_MAX_ALLOWED < 150000
//    NSLog(@"最大版本iOS15.0 不包含iOS15.0")
//#endif
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[TJViewController new]];
    self.window.rootViewController = nav;
    [self.window makeKeyWindow];
    return YES;
}


@end
