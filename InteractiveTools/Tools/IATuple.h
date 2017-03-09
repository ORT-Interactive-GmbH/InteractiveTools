//
//  IATuple.h
//  InteractiveTools
//
//  Created by Sebastian Westemeyer on 08.03.17.
//  Copyright © 2017 ORT Interactive GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IATuple <__covariant ObjectType1, __covariant ObjectType2> : NSObject<NSCopying>

- (instancetype)initWithFirst:(ObjectType1)first second:(ObjectType2)second;

@property (nonatomic, strong) ObjectType1 first;
@property (nonatomic, strong) ObjectType2 second;

@end
