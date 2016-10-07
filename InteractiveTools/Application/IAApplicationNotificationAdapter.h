//
//  IAApplicationNotificationAdapter.h
//
//  Created by Sebastian Westemeyer on 23.02.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IAApplicationNotificationDelegate <NSObject>
@optional
- (void)applicationWillEnterForeground:(NSNotification *)notification;
- (void)applicationDidEnterBackground:(NSNotification *)notification;
- (void)applicationDidBecomeActive:(NSNotification *)notification;
- (void)applicationWillTerminate:(NSNotification *)notification;
@end

@interface IAApplicationNotificationAdapter : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDelegate:(id<IAApplicationNotificationDelegate>)delegate;

@end
