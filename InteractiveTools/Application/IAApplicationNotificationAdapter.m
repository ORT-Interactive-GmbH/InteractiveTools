//
//  IAApplicationNotificationAdapter.m
//
//  Created by Sebastian Westemeyer on 23.02.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

#import "IAApplicationNotificationAdapter.h"
#import <UIKit/UIKit.h>

@interface IAApplicationNotificationAdapter ()
@property (nonatomic, strong) id<IAApplicationNotificationDelegate> delegate;
@end

@implementation IAApplicationNotificationAdapter

- (instancetype)initWithDelegate:(id<IAApplicationNotificationDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;

        NSNotificationCenter *nCenter = [NSNotificationCenter defaultCenter];
        if ([self.delegate respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            [nCenter addObserver:self
                        selector:@selector(applicationWillEnterForeground:)
                            name:UIApplicationWillEnterForegroundNotification
                          object:nil];
        }

        if ([self.delegate respondsToSelector:@selector(applicationDidEnterBackground:)]) {
            [nCenter addObserver:self
                        selector:@selector(applicationDidEnterBackground:)
                            name:UIApplicationDidEnterBackgroundNotification
                          object:nil];
        }

        if ([self.delegate respondsToSelector:@selector(applicationWillTerminate:)]) {
            [nCenter addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
        }

        if ([self.delegate respondsToSelector:@selector(applicationDidBecomeActive:)]) {
            [nCenter addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        }
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    [self.delegate applicationWillEnterForeground:notification];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    [self.delegate applicationDidEnterBackground:notification];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    [self.delegate applicationWillTerminate:notification];
}

- (void)applicationDidBecomeActive:(NSNotification *) notification{
    [self.delegate applicationDidBecomeActive:notification];
}

@end
