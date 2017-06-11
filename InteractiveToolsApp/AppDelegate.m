//
//  AppDelegate.m
//  InteractiveToolsApp
//
//  Created by Sebastian Westemeyer on 07.10.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

#import "AppDelegate.h"
#import "IATouchHandler.h"
#import "IATouchHandlerDelegate.h"
#import "IAPushHandler.h"

@interface AppDelegate ()
@property (nonatomic, strong) IATouchHandler *touchHandler;
@property (nonatomic, strong) IAPushHandler *pushHandler;
@end

@implementation AppDelegate

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        self.touchHandler = [[IATouchHandler alloc] initWithDelegate:[[IATouchHandlerDelegate alloc] init]];
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.pushHandler = [IAPushHandler initWithLaunchOptions:launchOptions
        urlPlistKey:@"WEB_BASE_URL"
        handleNotificationReceived:^(IANotification *notification, BOOL hasBeenOpened) {
            NSLog(@"Notification received");
        }
        settings:@{
            kIASettingsKeyPushTokenParameterName : @"identifier",
            kIASettingsKeyDeviceTypeParameterName : @"os_type",
            kIASettingsKeyAutoPrompt : @NO,
            kIASettingsKeyUsePostRequest : @YES
        }];
    // Override point for customization after application launch.
    return [self.touchHandler checkLaunchOptions:launchOptions forApplication:application];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [self.pushHandler application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self.pushHandler application:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Error: %@", error.localizedDescription);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions
    // (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background
    // state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to
    // pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to
    // restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the
    // background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the
    // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 3D Touch handling
- (void)application:(UIApplication *)application
    performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
               completionHandler:(void (^)(BOOL))completionHandler {
    completionHandler([self.touchHandler handleShortcutItem:shortcutItem]);
}

@end
