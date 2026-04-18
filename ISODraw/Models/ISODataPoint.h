//
//  ISODataPoint.h
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ISODataPoint : NSObject

@property (nonatomic, readonly) double x;
@property (nonatomic, readonly) double y;
@property (nonatomic, readonly) double value;

- (instancetype)initWithX:(double)x y:(double)y value:(double)value;
+ (nullable instancetype)pointFromDictionary:(NSDictionary *)dictionary;

- (NSDictionary<NSString *, NSNumber *> *)dictionaryRepresentation;

@end

NS_ASSUME_NONNULL_END
