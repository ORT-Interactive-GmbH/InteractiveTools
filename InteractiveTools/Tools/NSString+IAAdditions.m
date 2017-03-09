//
//  NSString+Additions.m
//  InteractiveTools
//
//  Created by Sebastian Westemeyer
//  Copyright (c) 2016 ORT Interactive GmbH. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (BOOL)validEmail {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    return [self match:emailRegex];
}

- (BOOL)match:(NSString *)regEx {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [predicate evaluateWithObject:self];
}

- (NSArray<NSString *> *)group:(NSString *)regEx {
    // init vars
    NSTextCheckingResult *match = nil;
    NSError *error = nil;
    // create new empty array
    NSMutableArray<NSString *> *retVal = [NSMutableArray<NSString *> array];
    // regular expression
    NSRegularExpression *expression =
        [NSRegularExpression regularExpressionWithPattern:regEx options:NSRegularExpressionCaseInsensitive error:&error];
    // expression might not be correct
    if (error == nil) {
        // try to match URL for QR code link
        match = [expression firstMatchInString:self options:NSMatchingAnchored range:NSMakeRange(0, self.length)];
        // might still be no match
        if (match != nil) {
            // iterate results
            for (int i = 0; i < match.numberOfRanges; ++i) {
                // add each match to result array
                NSRange range = [match rangeAtIndex:i];
                [retVal addObject:[self substringWithRange:range]];
            }
        }
    }

    return retVal;
}

- (NSString *)replaceMatches:(NSString *)regEx byTemplate:(NSString *)tmpl {
    // init vars
    NSError *error = nil;
    // regular expression
    NSRegularExpression *expression =
        [NSRegularExpression regularExpressionWithPattern:regEx options:NSRegularExpressionCaseInsensitive error:&error];
    // expression might not be correct
    if (error != nil) {
        return nil;
    }

    return [expression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:tmpl];
}

@end
