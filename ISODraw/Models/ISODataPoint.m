//
//  ISODataPoint.m
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import "ISODataPoint.h"

@implementation ISODataPoint

- (instancetype)initWithX:(double)x y:(double)y value:(double)value {
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
        _value = value;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

- (NSDictionary<NSString *,NSNumber *> *)dictionaryRepresentation {
    return @{
        @"x": @(self.x),
        @"y": @(self.y),
        @"value": @(self.value)
    };
}

+ (instancetype)pointFromDictionary:(NSDictionary *)dictionary {
    NSNumber *x = dictionary[@"x"];
    NSNumber *y = dictionary[@"y"];
    NSNumber *value = dictionary[@"value"];
    if (x == nil || y == nil || value == nil) {
        return nil;
    }

    return [[ISODataPoint alloc] initWithX:x.doubleValue y:y.doubleValue value:value.doubleValue];
}

@end
