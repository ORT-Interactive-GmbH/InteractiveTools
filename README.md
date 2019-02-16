InteractiveTools - a Toolbox for various solutions used throughout some of the ORT Interactive projects.
------------------------------------------------------------

If you need an example, simply clone the repository and run the application (preferably on 3D touch enabled device as the simulator does not support 3D touch)

## Installation

The recommended approach for installing InteractiveTools is via the [CocoaPods][2] package manager, as it provides flexible dependency management and dead simple installation.

Current features:
- 3D touch handler class to be used with `UIApplicationShortcutItem`
- `UIApplication` lifecycle wrapper class
- `UIColor` category to generate colors from hex values
- Message Box util as wrapper around `UIAlertAction`
- Push message registration helpers

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Change to the directory of your Xcode project, and Create and Edit your Podfile and add RestKit:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
platform :ios, '8.0'

pod 'InteractiveTools'
```

Install into your project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file)

``` bash
$ open MyProject.xcworkspace
```

## Examples
### 3D Touch
You might want to implement an IATouchDelegate like this:
```objectivec
// content of file IATouchHandlerDelegate.h
#import "IATouchHandler.h"

@interface IATouchHandlerDelegate : NSObject<IATouchDelegate>

@end

// content of file IATouchHandlerDelegate.m
#import "IATouchHandlerDelegate.h"
#import "UIAlertController+IAAdditions.h"

@implementation IATouchHandlerDelegate

- (NSArray<UIApplicationShortcutItem *>*) handlerItems {
    // configure shortcuts
    return @[ [[UIApplicationShortcutItem alloc] initWithType:@"type1"
                                               localizedTitle:@"Play"
                                            localizedSubtitle:@"Start playing"
                                                         icon:[UIApplicationShortcutIcon iconWithType: UIApplicationShortcutIconTypePlay]
                                                     userInfo:nil],
              [[UIApplicationShortcutItem alloc] initWithType:@"type2"
                                               localizedTitle:@"Pause"
                                            localizedSubtitle:@"Pause playback"
                                                         icon:[UIApplicationShortcutIcon iconWithType: UIApplicationShortcutIconTypePause]
                                                     userInfo:nil] ];
}

- (BOOL) handleItem: (UIApplicationShortcutItem *) item atIndex: (NSUInteger) idx {
    // handle shortcuts
    switch (idx){
        case 0:
            [UIAlertController showMessage:@"Play shortcut handled" title:@"Shortcut handler" once:nil];
            break;
        case 1:
            [UIAlertController showMessage:@"Pause shortcut handled" title:@"Shortcut handler" once:nil];
            break;
        default:
            // return NO or implement a default action and return YES
            return NO;
    }
    return YES;
}

@end
```

Set up the AppDelegate like this:
```objectivec
// bind to language keys
#import "AppDelegate.h"
#import "IATouchHandler.h"
#import "IATouchHandlerDelegate.h"

@interface AppDelegate ()
@property(nonatomic, strong) IATouchHandler* touchHandler;
@end

@implementation AppDelegate

- (instancetype) init{
    self = [super init];
    if (self != nil){
        self.touchHandler = [[IATouchHandler alloc] initWithDelegate:[[IATouchHandlerDelegate alloc] init]];
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return [self.touchHandler checkLaunchOptions:launchOptions forApplication:application];
}

// 3D Touch handling
- (void) application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    completionHandler([self.touchHandler handleShortcutItem:shortcutItem]);
}

@end
```

### Push registration
Set up the AppDelegate like this:
```objectivec
// bind to language keys
#import "AppDelegate.h"
#import "IAPushHandler.h"

@interface AppDelegate ()
@property (nonatomic, strong) IAPushHandler *pushHandler;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.pushHandler = [IAPushHandler initWithLaunchOptions:launchOptions
        urlPlistKey:@"WEB_BASE_URL"
        handleNotificationReceived:^(IANotification *notification, BOOL hasBeenOpened) {
            NSLog(@"Notification received");
        }
        settings:@{
            kIASettingsKeyPushTokenParameterName : @"identifier",
            kIASettingsKeyDeviceTypeParameterName : @"os_type",
            kIASettingsKeyAutoPrompt : @NO
        }];
    return YES;
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
    NSLog(@"Error!");
}

@end
```

Set up the `WEB_BASE_URL` in your `Info.plist` file as `$(WEB_BASE_URL)` and define a new user defined build setting named `WEB_BASE_URL`. A different web server URL can be set up per build configuration.

The push registration process is triggered by calling the static method `[IAPushHandler registerForPushNotifications]` anywhere in the project. If the registration should be started immediately after app starts, the `kIASettingsKeyAutoPrompt` setting can be left out in app delegate.

## Credits

## License :
  
The code is available as github [project][home] under [MIT licence][1].
  
   [home]: https://github.com/ORT-Interactive-GmbH/InteractiveTools
   [1]: https://github.com/swesteme/InteractiveTools/blob/master/LICENSE.md
   [2]: http://cocoapods.org
