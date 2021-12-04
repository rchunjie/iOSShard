//
//  TJDataSourceController+UNUserNotificationCenter.m
//  iOSShard
//
//  Created by 任春节 on 2021/12/4.
//

#import "TJDataSourceController+UNUserNotificationCenter.h"
#import <UserNotifications/UserNotifications.h>

@interface TJDataSourceController ()<UNUserNotificationCenterDelegate>

@end
@implementation TJDataSourceController (UNUserNotificationCenter)
- (void)_registerRemoteNotification{
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 100000
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay
                                             ) completionHandler:^(BOOL granted, NSError *_Nullable error) {
        if (!error) {
            NSLog(@"request authorization succeeded!");
        } }];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 100000 && __IPHONE_OS_VERSION_MIN_REQUIRED > 80000
    UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED <= 80000
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                   UIRemoteNotificationTypeSound |
                                                                   UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
    
}


// The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
}

// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from application:didFinishLaunchingWithOptions:.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    
}

// The method will be called on the delegate when the application is launched in response to the user's request to view in-app notification settings. Add UNAuthorizationOptionProvidesAppNotificationSettings as an option in requestAuthorizationWithOptions:completionHandler: to add a button to inline notification settings view and the notification settings view in Settings. The notification will be nil when opened from Settings.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(nullable UNNotification *)notification {
    
}


@end
