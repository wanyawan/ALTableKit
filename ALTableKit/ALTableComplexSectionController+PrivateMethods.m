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
#import "ALTableSectionControllerInternal.h"

@implementation ALTableComplexSectionController (PrivateMethods)

#pragma mark -- Private Methods

- (ALTableSectionProvider *)al_sectionProviderWithAbsoluteIndex:(NSUInteger)index {
    NSUInteger absoluteIndex = [self.indexMap sectionProviderAbsoluteIndexWithAbsoluteIndex:index];
    return [self.sectionProviders objectAtIndex:absoluteIndex];
}

#pragma mark -- Override Methods

- (void)al_beforeUpdateToObject:(id)object {
    self.totalOfRows = nil;
    if (self.cellHeightMap) {
        [self.cellHeightMap removeAllObjects];
    }
}

- (void)al_didUpdateToObject:(id)object {
    [self didUpdateToObject:object];
    NSArray *sectionProviders = [self updateSectionProvidersWithObject:object];
    for (ALTableSectionProvider *sectionProvider in sectionProviders) {
        [sectionProvider didUpdateToObject:object];
        sectionProvider.tableContext = self.tableContext;
        sectionProvider.viewController = self.viewController;
        sectionProvider.sectionController = self;
    }
    self.sectionProviders = [sectionProviders copy];
}

- (NSUInteger)al_numberOfRows {
    if (self.totalOfRows) {
        return [self.totalOfRows unsignedIntegerValue];
    }
    NSUInteger count = 0;
    for (ALTableSectionProvider *sectionProvider in self.sectionProviders) {
        count += [sectionProvider numberOfRows];
    }
    self.totalOfRows = [NSNumber numberWithUnsignedInteger:count];
    return count;
}

- (CGFloat)al_heightForRowAtIndex:(NSUInteger)index {
    NSUInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    return [sectionProvider heightForRowAtIndex:sectionProviderIndex];
}

- (UITableViewCell *)al_cellForRowAtIndex:(NSUInteger)index {
    NSUInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    return [sectionProvider cellForRowAtIndex:sectionProviderIndex];}

- (void)al_didSelectRowAtIndex:(NSUInteger)index {
    NSUInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    [sectionProvider didSelectRowAtIndex:sectionProviderIndex];
}

- (void)al_didDeselectRowAtIndex:(NSUInteger)index {
    NSUInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    [sectionProvider didDeselectRowAtIndex:sectionProviderIndex];
}

- (BOOL)al_canEditRowAtIndex:(NSUInteger)index {
    NSUInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    return [sectionProvider canEditRowAtIndex:sectionProviderIndex];
}

- (UITableViewCellEditingStyle)al_editingStyleForRowAtIndex:(NSUInteger)index {
    NSUInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    return [sectionProvider editingStyleForRowAtIndex:sectionProviderIndex];
}

- (nullable NSString *)al_titleForDeleteConfirmationButtonForRowAtIndex:(NSUInteger)index {
    NSUInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    return [sectionProvider titleForDeleteConfirmationButtonForRowAtIndex:sectionProviderIndex];
}

- (void)al_commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndex:(NSUInteger)index {
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    NSUInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    return [sectionProvider commitEditingStyle:editingStyle forRowAtIndex:sectionProviderIndex];
}

- (nullable NSArray<UITableViewRowAction *> *)al_editActionsForRowAtIndex:(NSUInteger)index NS_AVAILABLE_IOS(8_0) {
    NSUInteger sectionProviderIndex = [self.indexMap sectionProviderRelativeIndexWithAbsoluteIndex:index];
    ALTableSectionProvider *sectionProvider = [self al_sectionProviderWithAbsoluteIndex:index];
    return [sectionProvider editActionsForRowAtIndex:sectionProviderIndex];
}

@end
