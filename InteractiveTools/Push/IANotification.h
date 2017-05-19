//
//  IANotification.h
//  InteractivePushApp
//
//  Created by Sebastian Westemeyer on 10.05.17.
//  Copyright © 2017 ORT Interactive GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IANotification : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;
+ (instancetype)notificationFromUserInfo:(NSDictionary *)userInfo;
- (instancetype)initFromUserInfo:(NSDictionary *)userInfo;

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *subtitle;
@property (nonatomic, strong, readonly) NSString *message;
@property (nonatomic, strong, readonly) NSDictionary *extraData;

@end
