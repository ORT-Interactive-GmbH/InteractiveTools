//
//  IAPushHandler.h
//  InteractivePushApp
//
//  Created by Sebastian Westemeyer on 10.05.17.
//  Copyright © 2017 ORT Interactive GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IANotification;

extern NSString const *kIASettingsKeyAutoPrompt;
extern NSString const *kIASettingsKeyUsePostRequest;
extern NSString const *kIASettingsAdditionalParameters;
extern NSString const *kIASettingsKeyPushTokenParameterName;
extern NSString const *kIASettingsKeyDeviceTypeParameterName;

/* Block for handling the reception of a remote notification */
typedef void (^IAHandleNotificationReceivedBlock)(IANotification *notification, BOOL hasBeenTapped);

@interface IAPushHandler : NSObject

+ (instancetype)initWithLaunchOptions:(NSDictionary *)launchOptions
                          urlPlistKey:(NSString *)key
           handleNotificationReceived:(IAHandleNotificationReceivedBlock)receivedCallback
                             settings:(NSDictionary *)settings;
+ (instancetype)initWithLaunchOptions:(NSDictionary *)launchOptions
                           backendURL:(NSString *)url
           handleNotificationReceived:(IAHandleNotificationReceivedBlock)receivedCallback
                             settings:(NSDictionary *)settings;

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

// only use the following method if you set kIASettingsKeyAutoPrompt to @NO
+ (void)registerForPushNotifications;
+ (NSString *)currentPushToken;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

@end
