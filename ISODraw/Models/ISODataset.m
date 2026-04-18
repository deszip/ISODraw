//
//  ISODataset.m
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import "ISODataset.h"

@implementation ISODataset

- (instancetype)initWithIdentifier:(NSString *)identifier
                              name:(NSString *)name
                         createdAt:(NSDate *)createdAt
                       centerPoint:(ISODataPoint *)centerPoint
                      samplePoints:(NSArray<ISODataPoint *> *)samplePoints {
    self = [super init];
    if (self) {
        _identifier = [identifier copy];
        _name = [name copy];
        _createdAt = createdAt;
        _centerPoint = centerPoint;
        _samplePoints = [samplePoints copy];
    }
    return self;
}

- (NSArray<ISODataPoint *> *)allPoints {
    NSMutableArray<ISODataPoint *> *points = [self.samplePoints mutableCopy];
    [points addObject:self.centerPoint];
    return [points copy];
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableArray<NSDictionary *> *serializedPoints = [NSMutableArray arrayWithCapacity:self.samplePoints.count];
    for (ISODataPoint *point in self.samplePoints) {
        [serializedPoints addObject:point.dictionaryRepresentation];
    }

    return @{
        @"identifier": self.identifier,
        @"name": self.name,
        @"createdAt": @([self.createdAt timeIntervalSince1970]),
        @"centerPoint": self.centerPoint.dictionaryRepresentation,
        @"samplePoints": serializedPoints
    };
}

+ (instancetype)datasetFromDictionary:(NSDictionary *)dictionary {
    NSString *identifier = dictionary[@"identifier"];
    NSString *name = dictionary[@"name"];
    NSNumber *timestamp = dictionary[@"createdAt"];
    ISODataPoint *centerPoint = [ISODataPoint pointFromDictionary:dictionary[@"centerPoint"]];
    NSArray *serializedPoints = dictionary[@"samplePoints"];

    if (identifier.length == 0 || name.length == 0 || timestamp == nil || centerPoint == nil || ![serializedPoints isKindOfClass:[NSArray class]]) {
        return nil;
    }

    NSMutableArray<ISODataPoint *> *samplePoints = [NSMutableArray arrayWithCapacity:serializedPoints.count];
    for (NSDictionary *pointDictionary in serializedPoints) {
        ISODataPoint *point = [ISODataPoint pointFromDictionary:pointDictionary];
        if (point != nil) {
            [samplePoints addObject:point];
        }
    }

    NSDate *createdAt = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue];
    return [[ISODataset alloc] initWithIdentifier:identifier
                                             name:name
                                        createdAt:createdAt
                                      centerPoint:centerPoint
                                     samplePoints:samplePoints];
}

@end
