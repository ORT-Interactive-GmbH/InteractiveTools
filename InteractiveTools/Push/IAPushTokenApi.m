//
//  IAPushTokenApi.m
//  InteractiveToolsApp
//
//  Created by Sebastian Westemeyer on 17.05.17.
//  Copyright © 2017 ORT Interactive. All rights reserved.
//

#import "IAPushTokenApi.h"
#import "NSDictionary+IAAdditions.h"

NSString const *kIADefaultGetParameterToken = @"pushToken";
NSString const *kIADefaultGetParameterDevice = @"pushDeviceType";
NSString const *kIAGetParameterValueIos = @"ios";

@interface IAPushTokenApi ()
@property (nonatomic, strong) NSString *backendURL;
@property (nonatomic, strong) NSString *pushTokenParameter;
@property (nonatomic, strong) NSString *deviceTypeParameter;
@end

@implementation IAPushTokenApi

- (instancetype)initWithUrl:(NSString *)url pushTokenParam:(NSString *)pushTokenParam deviceTypeParam:(NSString *)deviceTypeParam {
    self = [super init];
    if (self) {
        self.backendURL = url;
        self.pushTokenParameter = pushTokenParam ?: kIADefaultGetParameterToken;
        self.deviceTypeParameter = deviceTypeParam ?: kIADefaultGetParameterDevice;
    }

    return self;
}

- (void)sendPushToken:(NSString *)token {
    // get parameter dictionary
    NSDictionary *params = [self parameterDictionary:token];
    // the backend URL may already contain a questionmark for GET parameters
    NSString *concatenationCharacter = [self.backendURL containsString:@"?"] ? @"&" : @"?";
    // concatenate URL string
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [NSURL URLWithString:self.backendURL],
                                                     [params buildQueryStringWithConcatenationCharacter:concatenationCharacter]];
    // prepare request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod = @"GET";
    // execute request
    [[[NSURLSession sharedSession] dataTaskWithRequest:request] resume];
}

- (NSDictionary *)parameterDictionary:(NSString *)token {
    return @{self.pushTokenParameter : token, self.deviceTypeParameter : kIAGetParameterValueIos};
}

@end
