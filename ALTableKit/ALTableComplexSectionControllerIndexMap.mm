//
//  ALTableComplexSectionControllerIndexMap.m
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableComplexSectionControllerIndexMap.h"
#import "ALTableSectionProviderInternal.h"
#import <ALTableKit/ALTableAssert.h>

#import <vector>

typedef struct {
    NSUInteger sectionProviderIndex;
    NSUInteger relativeIndex;
} ALTableSectionProviderIndex;

@implementation ALTableComplexSectionControllerIndexMap
{
    std::vector<ALTableSectionProviderIndex> _indexVector;
}

- (void)updateIndexMapWithSectionProviders:(NSArray<ALTableSectionProvider *> *)sectionProviders {
    _indexVector.clear();
    NSUInteger totalCount = 0;
    for (NSUInteger sectionProviderIndex = 0; sectionProviderIndex < sectionProviders.count; sectionProviderIndex++) {
        ALTableSectionProvider *sectionProvider = [sectionProviders objectAtIndex:sectionProviderIndex];
        sectionProvider.sectionProviderIndex = sectionProviderIndex;
        sectionProvider.firstCellAbsoluteIndex = totalCount;
        NSUInteger count = [sectionProvider numberOfRows];
        totalCount += count;
        for (NSUInteger relativeIndex = 0; relativeIndex < count; relativeIndex++) {
            ALTableSectionProviderIndex *index = (ALTableSectionProviderIndex*)malloc(sizeof(ALTableSectionProviderIndex));
            index->sectionProviderIndex = sectionProviderIndex;
            index->relativeIndex = relativeIndex;
            _indexVector.push_back(*index);
        }
    }
    ALParameterAssert(totalCount == _indexVector.size());
}

- (NSUInteger)sectionProviderAbsoluteIndexWithAbsoluteIndex:(NSUInteger)index {
    ALParameterAssert(index < _indexVector.size());
    return _indexVector[index].sectionProviderIndex;;
}

- (NSUInteger)sectionProviderRelativeIndexWithAbsoluteIndex:(NSUInteger)index {
    ALParameterAssert(index < _indexVector.size());
    return _indexVector[index].relativeIndex;;
}

@end
