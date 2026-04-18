//
//  ISODataset.h
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import <Foundation/Foundation.h>

#import "ISODataPoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface ISODataset : NSObject

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSDate *createdAt;
@property (nonatomic, strong, readonly) ISODataPoint *centerPoint;
@property (nonatomic, copy, readonly) NSArray<ISODataPoint *> *samplePoints;

- (instancetype)initWithIdentifier:(NSString *)identifier
                              name:(NSString *)name
                         createdAt:(NSDate *)createdAt
                       centerPoint:(ISODataPoint *)centerPoint
                      samplePoints:(NSArray<ISODataPoint *> *)samplePoints;

- (NSArray<ISODataPoint *> *)allPoints;
- (NSDictionary *)dictionaryRepresentation;
+ (nullable instancetype)datasetFromDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
