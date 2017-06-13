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
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *additionalParams;
@end

@implementation IAPushTokenApi

- (instancetype)initWithUrl:(NSString *)url
             pushTokenParam:(NSString *)pushTokenParam
            deviceTypeParam:(NSString *)deviceTypeParam
           additionalParams:(NSDictionary<NSString *, NSString *> *)params {
    self = [super init];
    if (self) {
        self.usePostRequest = NO;
        self.backendURL = url;
        self.pushTokenParameter = pushTokenParam ?: kIADefaultGetParameterToken;
        self.deviceTypeParameter = deviceTypeParam ?: kIADefaultGetParameterDevice;
        self.additionalParams = params;
    }

    return self;
}

- (void)sendPushToken:(NSString *)token {
    // the request pointer to be set up with either GET or POST request
    NSMutableURLRequest *request = nil;
    // the backend URL as NSURL
    NSURL *theBackendURL = [NSURL URLWithString:self.backendURL];
    // get parameter dictionary
    NSDictionary *params = [self parameterDictionary:token];

    if (self.usePostRequest) {
        NSString *post = [params buildQueryStringWithConcatenationCharacter:@""];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

        request = [NSMutableURLRequest requestWithURL:theBackendURL];

        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
    } else {
        // the backend URL may already contain a questionmark for GET parameters
        NSString *concatenationCharacter = [self.backendURL containsString:@"?"] ? @"&" : @"?";
        // concatenate URL string
        NSString *urlString =
            [NSString stringWithFormat:@"%@%@", theBackendURL, [params buildQueryStringWithConcatenationCharacter:concatenationCharacter]];
        // prepare request
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        request.HTTPMethod = @"GET";
    }

    // execute request
    [[[NSURLSession sharedSession] dataTaskWithRequest:request] resume];
}

- (NSDictionary *)parameterDictionary:(NSString *)token {
    // create storage for parameters
    NSMutableDictionary<NSString *, NSString *> *dict = [NSMutableDictionary
        dictionaryWithDictionary:@{self.pushTokenParameter : token, self.deviceTypeParameter : kIAGetParameterValueIos}];
    // might want to add additional parameters
    if (self.additionalParams && self.additionalParams.count > 0) {
        [dict addEntriesFromDictionary:self.additionalParams];
    }
    return dict;
}

@end
