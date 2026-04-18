//
//  ISODatasetStore.h
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import <Foundation/Foundation.h>

#import "ISODataset.h"

NS_ASSUME_NONNULL_BEGIN

@interface ISODatasetStore : NSObject

- (NSArray<ISODataset *> *)loadDatasets;
- (BOOL)saveDatasets:(NSArray<ISODataset *> *)datasets error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
