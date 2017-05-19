//
//  NSDictionary+IAAdditions.h
//  InteractiveToolsApp
//
//  Created by Sebastian Westemeyer on 18.05.17.
//  Copyright © 2017 ORT Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (IAAdditions)

- (NSString *)buildQueryStringWithConcatenationCharacter:(NSString *)character;
- (NSString *)buildQueryString;

@end
