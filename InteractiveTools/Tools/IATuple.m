//
//  IATuple.m
//  InteractiveTools
//
//  Created by Sebastian Westemeyer on 08.03.17.
//  Copyright © 2017 ORT Interactive GmbH. All rights reserved.
//

#import "IATuple.h"

@implementation IATuple

- (instancetype)initWithFirst:(id)first second:(id)second {
    self = [super init];
    if (self != nil) {
        self.first = first;
        self.second = second;
    }
    return self;
}

- (BOOL)isEqualToTuple:(IATuple *)tuple {
    if (!tuple) {
        return NO;
    }

    BOOL haveEqualFirst = (!self.first && !tuple.first) || [self.first isEqual:tuple.first];
    BOOL haveEqualSecond = (!self.second && !tuple.second) || [self.second isEqual:tuple.second];

    return haveEqualFirst && haveEqualSecond;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    IATuple *copy = [[[self class] allocWithZone:zone] init];
    copy->_first = [self.first copyWithZone:zone];
    copy->_second = [self.second copyWithZone:zone];
    return copy;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[IATuple class]]) {
        return NO;
    }

    return [self isEqualToTuple:(IATuple *)object];
}

- (NSUInteger)hash {
    return [self.first hash] ^ [self.second hash];
}
@end
