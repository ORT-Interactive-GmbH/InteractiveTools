//
//  IAPushHandler.m
//  InteractivePushApp
//
//  Created by Sebastian Westemeyer on 10.05.17.
//  Copyright © 2017 ORT Interactive GmbH. All rights reserved.
//

#import "IAPushHandler.h"
#import "IANotification.h"
#import "IAPushTokenApi.h"
#import "NSData+IAAdditions.h"
#import "IAApplicationNotificationAdapter.h"

NSString const *kIASettingsKeyAutoPrompt = @"kIASettingsKeyAutoPrompt";
NSString const *kIASettingsKeyPushTokenParameterName = @"kIASettingsKeyPushTokenParameterName";
NSString const *kIASettingsKeyDeviceTypeParameterName = @"kIASettingsKeyDeviceTypeParameterName";
NSString *kIAUserDefaultsKeyToken = @"kIAUserDefaultsKeyToken";

@interface IAPushHandler () <IAApplicationNotificationDelegate>

@property (nonatomic, strong) IAPushTokenApi *apiSession;
@property (nonatomic, strong) IAApplicationNotificationAdapter *notificationAdapter;
@property (nonatomic, assign) BOOL pushedToBackground;
@property (nonatomic, assign) IAHandleNotificationReceivedBlock notificationReceivedBlock;

@end

@implementation IAPushHandler

+ (instancetype)initWithLaunchOptions:(NSDictionary *)launchOptions
                          urlPlistKey:(NSString *)key
           handleNotificationReceived:(IAHandleNotificationReceivedBlock)receivedCallback
                             settings:(NSDictionary *)settings {
    // get key from main bundle's info plist file
    NSString *url = [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
    // call init method
    return [IAPushHandler initWithLaunchOptions:launchOptions backendURL:url handleNotificationReceived:receivedCallback settings:settings];
}

+ (instancetype)initWithLaunchOptions:(NSDictionary *)launchOptions
                           backendURL:(NSString *)url
           handleNotificationReceived:(IAHandleNotificationReceivedBlock)receivedCallback
                             settings:(NSDictionary *)settings {
    // call init method
    return [[IAPushHandler alloc] initWithLaunchOptions:launchOptions
                                             backendURL:url
                             handleNotificationReceived:receivedCallback
                                               settings:settings];
}

- (instancetype)initWithLaunchOptions:(NSDictionary *)launchOptions
                           backendURL:(NSString *)url
           handleNotificationReceived:(IAHandleNotificationReceivedBlock)receivedCallback
                             settings:(NSDictionary *)settings {
    self = [super init];
    if (self) {
        UIApplication *app = [UIApplication sharedApplication];
        self.pushedToBackground = NO;
        self.notificationReceivedBlock = receivedCallback;
        self.apiSession = [[IAPushTokenApi alloc] initWithUrl:url
                                               pushTokenParam:[settings objectForKey:kIASettingsKeyPushTokenParameterName]
                                              deviceTypeParam:[settings objectForKey:kIASettingsKeyDeviceTypeParameterName]];
        self.notificationAdapter = [[IAApplicationNotificationAdapter alloc] initWithDelegate:self];

        // get auto prompt configuration
        id object = [settings objectForKey:kIASettingsKeyAutoPrompt];
        // evaluate auto-prompt setting
        if (object == nil || [object boolValue]) {
            [IAPushHandler registerForPushNotifications:app];
        }
    }

    return self;
}

#pragma mark - Push handling

+ (NSString *)currentPushToken {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kIAUserDefaultsKeyToken];
}

+ (void)registerForPushNotifications {
    [self registerForPushNotifications:[UIApplication sharedApplication]];
}

+ (void)registerForPushNotifications:(UIApplication *)application {
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"Push: Skipping push notifications in simulator");
#else
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wassign-enum"
    UIUserNotificationType types = (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert);
#pragma clang diagnostic pop
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:types categories:nil]];
#endif
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // keep token for later reference (can be retrieved using currentPushToken method)
    NSString *token = [deviceToken extractToken];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:kIAUserDefaultsKeyToken];
    [userDefaults synchronize];

    [self.apiSession sendPushToken:token];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    self.notificationReceivedBlock([IANotification notificationFromUserInfo:userInfo], !self.pushedToBackground);
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    // application is pushed to background
    self.pushedToBackground = YES;
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    // application is not in background anymore
    self.pushedToBackground = NO;
}

@end
