//
//  IATouchHandler.h
//  IA
//
//  Created by Sebastian Westemeyer on 06.10.16.
//  Copyright © 2016 ORT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IATouchDelegate <NSObject>

- (NSArray<UIApplicationShortcutItem *>*) handlerItems;
- (BOOL) handleItem: (UIApplicationShortcutItem *) item atIndex: (NSUInteger) idx;

@end

@interface IATouchHandler : NSObject

@property (nonatomic, strong) UIApplicationShortcutItem* launchedShortcutItem;

- (instancetype) initWithDelegate: (id<IATouchDelegate>) delegate;
- (instancetype) init NS_UNAVAILABLE;

- (BOOL) checkLaunchOptions:(NSDictionary *)launchOptions forApplication: (UIApplication *) application;
- (BOOL) handleShortcutItem:(UIApplicationShortcutItem*) item;
- (BOOL) handleShortcutItem;

@end
