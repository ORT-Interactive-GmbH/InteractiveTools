//
//  NSData+IAAdditions.m
//  InteractiveToolsApp
//
//  Created by Sebastian Westemeyer on 09.02.17.
//  Copyright © 2017 ORT Interactive. All rights reserved.
//

#import "NSData+IAAdditions.h"

@implementation NSData (IAAdditions)

- (NSString *)extractToken {
    return [[self.description componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"< >"]]
        componentsJoinedByString:@""];
}
@end
