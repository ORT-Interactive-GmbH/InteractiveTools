//
//  UIColor+IAAdditions.m
//

#import "UIColor+IAAdditions.h"

@implementation UIColor (UIColor_IAAdditions)

+ (id)colorWithInteger:(NSUInteger)color
{
	return [[UIColor alloc] initWithInteger:color];
}

- (id)initWithInteger:(NSUInteger)color
{
	NSUInteger blue = color & 0xff;
	color >>= 8;
	NSUInteger green = color & 0xff;
	color >>= 8;
	NSUInteger red = color & 0xff;
	
	return [self initWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1.f];
}

@end
