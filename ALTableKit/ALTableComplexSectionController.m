//
//  ALTableComplexSectionController.m
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <ALTableKit/ALTableSectionProvider.h>
#import <ALTableKit/ALTableAssert.h>
#import "ALTableComplexSectionControllerInternal.h"
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

- (void)didUpdateToObject:(id)object {}

- (NSArray <ALTableSectionProvider *> *)updateSectionProvidersWithObject:(id)object {
    ALFailAssert(@"Complex Section controller %@ must override %s:", self, __PRETTY_FUNCTION__);
    return @[];
}

#pragma mark -- Private Methods

- (void)setSectionProviders:(NSArray<ALTableSectionProvider *> *)sectionProviders {
    _sectionProviders = sectionProviders;
    [_indexMap updateIndexMapWithSectionProviders:sectionProviders];
}

/**
 * ALTableComplexSectionController isn’t Implementing these method. Use ALTableSectionProvider to edit cells.
 * ALTableComplexSectionController编辑cell 在ALTableSectionProvider中编辑
 */
- (void)insertRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object {}

- (void)deleteRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object {}

- (void)reloadRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object {}

@end
