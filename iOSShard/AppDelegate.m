//
//  AppDelegate.m
//  iOSShard
//
//  Created by 任春节 on 2021/9/7.
//

#import "AppDelegate.h"
#import "TJViewController.h"
#import "RMFpsLabel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[TJViewController new]];
    self.window.rootViewController = nav;
    [self.window makeKeyWindow];
    RMFpsLabel *label = [RMFpsLabel new];
    [nav.view insertSubview:label atIndex:1000];
    return YES;
}


@end
