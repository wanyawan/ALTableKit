//
//  ALTableComplexSectionController+PrivateMethods.m
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableComplexSectionController+PrivateMethods.h"
#import "ALTableComplexSectionControllerInternal.h"
#import "ALTableSectionProviderInternal.h"

@implementation ALTableComplexSectionController (PrivateMethods)

#pragma mark -- Private Methods

- (ALTableSectionProvider *)al_sectionProviderWithAbsoluteIndex:(NSInteger)index {
    NSInteger absoluteIndex = [self.indexMap sectionProviderAbsoluteIndexWithAbsoluteIndex:index];
    return [self.sectionProviders objectAtIndex:absoluteIndex];
}

#pragma mark -- Override Methods

- (void)al_didUpdateToObject:(id)object {
    NSArray *sectionProviders = [self updateSectionProvidersWithObject:object];
    for (ALTableSectionProvider *sectionProvider in sectionProviders) {
        [sectionProvider didUpdateToObject:object];
        sectionProvider.tableContext = self.tableContext;
        sectionProvider.viewController = self.viewController;
        sectionProvider.sectionController = self;
    }
    self.sectionProviders = [sectionProviders copy];
}

- (NSInteger)al_numberOfRows {
    NSInteger count = 0;
    for (ALTableSectionProvider *sectionProvider in self.sectionProviders) {
        count += [sectionProvider numberOfRows];
    }
    return count;
}

- (CGFloat)al_heightForRowAtIndex:(NSInteger)index {
    NSInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    return [sectionProvider heightForRowAtIndex:sectionProviderIndex];
}

- (UITableViewCell *)al_cellForRowAtIndex:(NSInteger)index {
    NSInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    return [sectionProvider cellForRowAtIndex:sectionProviderIndex];}

- (void)al_didSelectRowAtIndex:(NSInteger)index {
    NSInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    [sectionProvider didSelectRowAtIndex:sectionProviderIndex];
}

- (void)al_didDeselectRowAtIndex:(NSInteger)index {
    NSInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    [sectionProvider didDeselectRowAtIndex:sectionProviderIndex];
}

@end
