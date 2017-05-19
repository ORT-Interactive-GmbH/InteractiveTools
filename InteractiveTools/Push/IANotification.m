//
//  IANotification.m
//  InteractivePushApp
//
//  Created by Sebastian Westemeyer on 10.05.17.
//  Copyright © 2017 ORT Interactive GmbH. All rights reserved.
//

#import "IANotification.h"

@implementation IANotification

+ (instancetype)notificationFromUserInfo:(NSDictionary *)userInfo {
    return [[IANotification alloc] initFromUserInfo:userInfo];
}

- (instancetype)initFromUserInfo:(NSDictionary *)userInfo {
    self = [super init];
    if (self) {
        NSDictionary *alert = userInfo[@"aps"][@"alert"];
        _title = alert[@"title"];
        _subtitle = alert[@"subtitle"];
        _message = alert[@"body"];
        _extraData = userInfo;
    }
    return self;
}

@end
