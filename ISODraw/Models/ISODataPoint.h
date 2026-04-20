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

- (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithX:(double)x y:(double)y value:(double)value NS_DESIGNATED_INITIALIZER;
+ (nullable instancetype)pointFromDictionary:(NSDictionary *)dictionary;

- (NSDictionary<NSString *, NSNumber *> *)dictionaryRepresentation;

@end

NS_ASSUME_NONNULL_END
