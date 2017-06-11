//
//  IAPushTokenApi.h
//  InteractiveToolsApp
//
//  Created by Sebastian Westemeyer on 17.05.17.
//  Copyright © 2017 ORT Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAPushTokenApi : NSObject

@property (nonatomic, assign) BOOL usePostRequest;

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithUrl:(NSString *)url pushTokenParam:(NSString *)pushTokenParam deviceTypeParam:(NSString *)deviceTypeParam;

- (void)sendPushToken:(NSString *)token;

@end
