//
//  ISODatasetStore.m
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import "ISODatasetStore.h"

@implementation ISODatasetStore

- (NSURL *)storageURLWithError:(NSError **)error {
    NSFileManager *fileManager = NSFileManager.defaultManager;
    NSURL *applicationSupportURL = [fileManager URLForDirectory:NSApplicationSupportDirectory
                                                       inDomain:NSUserDomainMask
                                              appropriateForURL:nil
                                                         create:YES
                                                          error:error];
    if (applicationSupportURL == nil) {
        return nil;
    }

    NSURL *directoryURL = [applicationSupportURL URLByAppendingPathComponent:@"IsolinesSample" isDirectory:YES];
    if (![fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:error]) {
        return nil;
    }

    return [directoryURL URLByAppendingPathComponent:@"datasets.json"];
}

- (NSArray<ISODataset *> *)loadDatasets {
    NSError *error = nil;
    NSURL *storageURL = [self storageURLWithError:&error];
    if (storageURL == nil) {
        NSLog(@"Failed to get storage URL: %@", error);
        return @[];
    }

    NSData *data = [NSData dataWithContentsOfURL:storageURL];
    if (data.length == 0) {
        NSLog(@"Storage is empty");
        return @[];
    }

    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (![object isKindOfClass:[NSArray class]]) {
        if (error != nil) {
            NSLog(@"Dataset loading error: %@", error);
        }
        return @[];
    }

    NSMutableArray<ISODataset *> *datasets = [NSMutableArray array];
    for (NSDictionary *dictionary in (NSArray *)object) {
        ISODataset *dataset = [ISODataset datasetFromDictionary:dictionary];
        if (dataset != nil) {
            [datasets addObject:dataset];
        }
    }

    return [datasets copy];
}

- (BOOL)saveDatasets:(NSArray<ISODataset *> *)datasets error:(NSError **)error {
    NSURL *storageURL = [self storageURLWithError:error];
    if (storageURL == nil) {
        NSLog(@"Failed to get storage URL: %@", *error);
        return NO;
    }

    NSMutableArray<NSDictionary *> *serializedDatasets = [NSMutableArray arrayWithCapacity:datasets.count];
    for (ISODataset *dataset in datasets) {
        [serializedDatasets addObject:dataset.dictionaryRepresentation];
    }

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:serializedDatasets
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:error];
    if (jsonData == nil) {
        NSLog(@"Failed to serialize datasets: %@", *error);
        return NO;
    }

    return [jsonData writeToURL:storageURL options:NSDataWritingAtomic error:error];
}

@end
