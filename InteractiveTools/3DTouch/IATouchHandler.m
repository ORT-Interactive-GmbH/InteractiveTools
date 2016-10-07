//
//  IATouchHandler.m
//  IA
//
//  Created by Sebastian Westemeyer on 06.10.16.
//  Copyright © 2016 ORT. All rights reserved.
//

#import "IATouchHandler.h"
#import "IAApplicationNotificationAdapter.h"

@interface IATouchHandler () <IAApplicationNotificationDelegate>
@property (strong, nonatomic) IAApplicationNotificationAdapter *applicationAdapter;
@property (strong, nonatomic) id<IATouchDelegate> delegate;
@property (strong, nonatomic) NSDictionary<NSString*, NSNumber*>* keyMap;
@end

@implementation IATouchHandler

- (instancetype) initWithDelegate: (id<IATouchDelegate>) delegate {
    self = [super init];
    if (self != nil) {
        // 3D touch is available from iOS 9
        if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_9_0) {
            self.applicationAdapter = [[IAApplicationNotificationAdapter alloc] initWithDelegate:self];
            self.delegate = delegate;
        }
    }
    return self;
}

// If a shortcut was launched, display its information and take the appropriate action
- (BOOL) checkLaunchOptions:(NSDictionary *)launchOptions forApplication: (UIApplication *) application {
    // should only be the case for operating systems < iOS 9
    if (self.delegate == nil) {
        return YES;
    }

    BOOL retVal = YES;

    // nothing to do without launch options
    if (launchOptions != nil){
        // try to find shortcut item
        UIApplicationShortcutItem* shortcutItem = [launchOptions objectForKey:UIApplicationLaunchOptionsShortcutItemKey];

        if (shortcutItem != nil){
            // keep launched item
            self.launchedShortcutItem = shortcutItem;
            retVal = NO;
        }
    }

    // get handler list from delegate
    NSArray<UIApplicationShortcutItem *>* array = self.delegate.handlerItems;

    // temporary object for index map
    NSMutableDictionary<NSString*, NSNumber*>* map = [[NSMutableDictionary<NSString*, NSNumber*> alloc] initWithCapacity:array.count];

    // keep all indeces for later reference
    [array enumerateObjectsUsingBlock:^(UIApplicationShortcutItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [map setObject:@(idx) forKey:obj.type];
    }];

    // keep reference to key/index map
    self.keyMap = map;

    // set shortcut items
    application.shortcutItems = array;

    // return whether or not to handle delegate methods in app delegate 
    return retVal;
}

- (BOOL) handleShortcutItem {
    return [self handleShortcutItem: self.launchedShortcutItem];
}

- (BOOL) handleShortcutItem:(UIApplicationShortcutItem*) item {
    if ( item == nil ) {
        return NO;
    }
    
    return [self.delegate handleItem:item atIndex:[[self.keyMap objectForKey:item.type] unsignedIntegerValue]];
}

#pragma mark - ApplicationNotificationDelegate

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    // nothing to do?
    if (self.launchedShortcutItem == nil){
        return;
    }

    // handle launched shortcut
    [self handleShortcutItem:self.launchedShortcutItem];

    self.launchedShortcutItem = nil;
}

@end
