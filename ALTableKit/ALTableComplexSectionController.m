//
//  ALTableComplexSectionController.m
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableComplexSectionControllerInternal.h"
#import "ALTableSectionProvider.h"
#import "ALTableAssert.h"
#import "ALTableComplexSectionControllerIndexMap.h"

@implementation ALTableComplexSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        _indexMap = [ALTableComplexSectionControllerIndexMap new];
    }
    return self;
}

#pragma mark -- Public Methods

- (NSArray <ALTableSectionProvider *> *)updateSectionProvidersWithObject:(id)object {
    ALFailAssert(@"Complex Section controller %@ must override %s:", self, __PRETTY_FUNCTION__);
    return @[];
}

#pragma mark -- Private Methods

- (void)setSectionProviders:(NSArray<ALTableSectionProvider *> *)sectionProviders {
    _sectionProviders = sectionProviders;
    [_indexMap updateIndexMapWithSectionProviders:sectionProviders];
}
//
//- (ALTableSectionProvider *)sectionProviderWithAbsoluteIndex:(NSInteger)index {
//    NSInteger absoluteIndex = [_indexMap sectionProviderAbsoluteIndexWithAbsoluteIndex:index];
//    return [self.sectionProviders objectAtIndex:absoluteIndex];
//}
//
//#pragma mark -- Override Methods
//
//- (void)al_didUpdateToObject:(id)object {
//    NSArray *sectionProviders = [self updateSectionProvidersWithObject:object];
//    for (ALTableSectionProvider *sectionProvider in sectionProviders) {
//        [sectionProvider didUpdateToObject:object];
//    }
//    self.sectionProviders = [sectionProviders copy];
//}
//
//- (NSInteger)al_numberOfRows {
//    NSInteger count = 0;
//    for (ALTableSectionProvider *sectionProvider in self.sectionProviders) {
//        count += [sectionProvider numberOfRows];
//    }
//    return count;
//}
//
//- (CGFloat)al_heightForRowAtIndex:(NSInteger)index {
//    NSInteger sectionProviderIndex = [_indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
//    ALTableSectionProvider *sectionProvider = [self sectionProviderWithAbsoluteIndex:index];
//    return [sectionProvider heightForRowAtIndex:sectionProviderIndex];
//}
//
//- (UITableViewCell *)al_cellForRowAtIndex:(NSInteger)index {
//    NSInteger sectionProviderIndex = [_indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
//    ALTableSectionProvider *sectionProvider = [self sectionProviderWithAbsoluteIndex:index];
//    return [sectionProvider cellForRowAtIndex:sectionProviderIndex];}
//
//- (void)al_didSelectRowAtIndex:(NSInteger)index {
//    NSInteger sectionProviderIndex = [_indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
//    ALTableSectionProvider *sectionProvider = [self sectionProviderWithAbsoluteIndex:index];
//    [sectionProvider didSelectRowAtIndex:sectionProviderIndex];
//}
//
//- (void)al_didDeselectRowAtIndex:(NSInteger)index {
//    NSInteger sectionProviderIndex = [_indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
//    ALTableSectionProvider *sectionProvider = [self sectionProviderWithAbsoluteIndex:index];
//    [sectionProvider didDeselectRowAtIndex:sectionProviderIndex];
//}

@end
