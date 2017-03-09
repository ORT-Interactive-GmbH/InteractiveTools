//
//  NSString+Additions.h
//  InteractiveTools
//
//  Created by Sebastian Westemeyer
//  Copyright (c) 2016 ORT Interactive GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IAAdditions)

- (BOOL)validEmail;

- (BOOL)match:(NSString *)regEx;

- (NSArray<NSString *> *)group:(NSString *)regEx;

- (NSString *)replaceMatches:(NSString *)regEx byTemplate:(NSString *)tmpl;

@end
