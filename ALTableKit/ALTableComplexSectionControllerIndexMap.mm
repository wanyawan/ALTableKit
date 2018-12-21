//
//  ALTableComplexSectionControllerIndexMap.m
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableComplexSectionControllerIndexMap.h"
#import "ALTableSectionProvider.h"
#import "ALTableAssert.h"
#import <vector>

typedef struct {
    NSInteger sectionProviderIndex;
    NSInteger relativeIndex;
} ALTableSectionProviderIndex;

@implementation ALTableComplexSectionControllerIndexMap
{
    std::vector<ALTableSectionProviderIndex> _indexVector;
}

- (void)updateIndexMapWithSectionProviders:(NSArray<ALTableSectionProvider *> *)sectionProviders {
    _indexVector.clear();
    NSInteger totalCount = 0;
    for (NSInteger sectionProviderIndex = 0; sectionProviderIndex < sectionProviders.count; sectionProviderIndex++) {
        ALTableSectionProvider *sectionProvider = [sectionProviders objectAtIndex:sectionProviderIndex];
        NSInteger count = [sectionProvider numberOfRows];
        totalCount += count;
        for (NSInteger relativeIndex = 0; relativeIndex < count; relativeIndex++) {
            ALTableSectionProviderIndex *index = (ALTableSectionProviderIndex*)malloc(sizeof(ALTableSectionProviderIndex));
            index->sectionProviderIndex = sectionProviderIndex;
            index->relativeIndex = relativeIndex;
            _indexVector.push_back(*index);
        }
    }
    ALParameterAssert(totalCount == _indexVector.size());
}

- (NSInteger)sectionProviderAbsoluteIndexWithAbsoluteIndex:(NSInteger)index {
    ALParameterAssert(index < _indexVector.size());
    return _indexVector[index].sectionProviderIndex;;
}

- (NSInteger)sectionProviderRelativeIndexWithAbsoluteIndex:(NSInteger)index {
    ALParameterAssert(index < _indexVector.size());
    return _indexVector[index].relativeIndex;;
}


@end
