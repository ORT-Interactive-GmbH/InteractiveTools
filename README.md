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
You might want to implement an IATouchDelegate like this:
``` Objective C
import InteractiveTools

class SharedManager {
    static let sharedInstance = LocalizationManager(languageProvider: UILanguageProvider(), defaultLanguage: "de", language: "de")

    private init() {}
}
```

And provide your own class implementing the `LanguageProvider` protocol, like the `UILanguageProvider` in the example above:
``` Objective C
// content of file IATouchHandlerDelegate.h
#import "IATouchHandler.h"

@interface IATouchHandlerDelegate : NSObject<IATouchDelegate>

@end

// content of file IATouchHandlerDelegate.m
#import "IATouchHandlerDelegate.h"
#import "IAMessageBoxUtil.h"

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
            [IAMessageBoxUtil showMessage:@"Play shortcut handled" title:@"Shortcut handler" once:nil];
            break;
        case 1:
            [IAMessageBoxUtil showMessage:@"Pause shortcut handled" title:@"Shortcut handler" once:nil];
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
``` Objective C
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
## Credits

## License :
  
The code is available as github [project][home] under [MIT licence][1].
  
   [home]: https://github.com/ORT-Interactive-GmbH/InteractiveTools
   [1]: http://revolunet.mit-license.org
   [2]: http://cocoapods.org
