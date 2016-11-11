//
//  IAToolsTest.m
//  InteractiveToolsApp
//
//  Created by Sebastian Westemeyer on 11.11.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Additions.h"

@interface IAToolsTest : XCTestCase

@end

@implementation IAToolsTest

- (void)testMatch {
    XCTAssert([@"abc" match:@"abc"]);
    XCTAssert([@"test my example   string" match:@"[^[:space:]]* my example[[:space:]]*string"]);
}

- (void) testGroup {
    NSArray<NSString *> *result = [@"test my example   string" group:@"([^[:space:]]*)[[:space:]]*([^[:space:]]*)[[:space:]]*([^[:space:]]*)[[:space:]]*([^[:space:]]*)"];
    XCTAssert(result.count == 5, @"Group regex result should not be empty");
    XCTAssert([result objectAtIndex:0], @"test my example   string");
    XCTAssert([result objectAtIndex:1], @"test");
    XCTAssert([result objectAtIndex:2], @"my");
    XCTAssert([result objectAtIndex:3], @"example");
    XCTAssert([result objectAtIndex:4], @"string");
}

- (void) checkReplace: (NSString *) string pattern: (NSString *) pattern template: (NSString *) template result: (NSString *) result {
    NSString *res = [string replaceMatches:pattern byTemplate:template];
    XCTAssert([res isEqualToString:result]);
}

- (void) testReplace {
    [self checkReplace:@"test my example   string" pattern:@"e" template:@"ö" result:@"töst my öxamplö   string"];
    [self checkReplace:@"test my example   string" pattern:@"[[:space:]]" template:@"" result:@"testmyexamplestring"];
//    [self checkReplace:@"http:\\www.google.de" pattern:@"\\" template:@"/" result:@"http://www.google.de"];
}

@end
