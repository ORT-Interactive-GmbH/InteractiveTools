//
//  NSDictionary+IAAdditions.m
//  InteractiveToolsApp
//
//  Created by Sebastian Westemeyer on 18.05.17.
//  Copyright © 2017 ORT Interactive. All rights reserved.
//

#import "NSDictionary+IAAdditions.h"

@implementation NSDictionary (IAAdditions)

- (NSString *)buildQueryStringWithConcatenationCharacter:(NSString *)character {
    __block NSString *urlVars = nil;

    [self enumerateKeysAndObjectsUsingBlock:^(NSString *_Nonnull key, NSString *_Nonnull value, BOOL *_Nonnull stop) {
        value = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        urlVars = [NSString stringWithFormat:@"%@%@%@=%@", urlVars ?: @"", urlVars ? @"&" : @"", key, value];
    }];

    return [NSString stringWithFormat:@"%@%@", urlVars ? character : @"", urlVars ?: @""];
}

- (NSString *)buildQueryString {
    return [self buildQueryStringWithConcatenationCharacter:@"?"];
}

@end
