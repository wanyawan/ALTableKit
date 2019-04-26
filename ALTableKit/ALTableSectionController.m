//
//  ALTableSectionController.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <ALTableKit/ALTableAssert.h>
#import "ALTableSectionControllerInternal.h"
#import "ALTableSectionController+PrivateMethods.h"
#import "ALTablePrivateContext.h"

@implementation ALTableSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.needCacheCellsHeight = YES;
    }
    return self;
}

- (void)setNeedCacheCellsHeight:(BOOL)needCacheCellsHeight {
    _needCacheCellsHeight = needCacheCellsHeight;
    if (needCacheCellsHeight) {
        if (!_cellHeightMap) {
            _cellHeightMap = [NSMapTable strongToStrongObjectsMapTable];
        }
    } else {
        _cellHeightMap = nil;
    }
}

#pragma mark -- Public Methods

- (void)didUpdateToObject:(id)object {}

- (NSUInteger)numberOfRows {
    return 0;
}

- (CGFloat)heightForRowAtIndex:(NSUInteger)index {
    return 0;
}

- (__kindof UITableViewCell *)cellForRowAtIndex:(NSUInteger)index {
    ALFailAssert(@"Section controller %@ must override %s:", self, __PRETTY_FUNCTION__);
    return nil;
}

- (void)didSelectRowAtIndex:(NSUInteger)index {}

- (void)didDeselectRowAtIndex:(NSUInteger)index {}

- (BOOL)canEditRowAtIndex:(NSUInteger)index {
    return NO;
}

- (UITableViewCellEditingStyle)editingStyleForRowAtIndex:(NSUInteger)index {
    return UITableViewCellEditingStyleDelete;
}

- (nullable NSString *)titleForDeleteConfirmationButtonForRowAtIndex:(NSUInteger)index {
    return nil;
}

- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndex:(NSUInteger)index {

}

- (nullable NSArray<UITableViewRowAction *> *)editActionsForRowAtIndex:(NSUInteger)index NS_AVAILABLE_IOS(8_0) {
    return nil;
}

/**
 * Section controller insert rows.Don't overwrite this method.
 * 插入行 直接使用不要重写这个方法
 */
- (void)insertRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object {
    ALAssertMainThread();
    ALParameterAssert(indexs != nil);
    NSUInteger section = self.section;
    NSMutableArray <NSIndexPath *> *indexPaths = [NSMutableArray arrayWithCapacity:indexs.count];
    [indexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:section];
        [indexPaths addObject:indexPath];
    }];
    [self al_beforeUpdateToObject:object];
    [self al_didUpdateToObject:object];
    id <ALTablePrivateContext> privateContext = (id <ALTablePrivateContext>)self.tableContext;
    [privateContext insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

/**
 * Section controller delete rows.Don't overwrite this method.
 * 删除行 直接使用不要重写这个方法
 */
- (void)deleteRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object {
    ALAssertMainThread();
    ALParameterAssert(indexs != nil);
    NSUInteger section = self.section;
    NSMutableArray <NSIndexPath *> *indexPaths = [NSMutableArray arrayWithCapacity:indexs.count];
    [indexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:section];
        [indexPaths addObject:indexPath];
    }];
    [self al_beforeUpdateToObject:object];
    [self al_didUpdateToObject:object];
    id <ALTablePrivateContext> privateContext = (id <ALTablePrivateContext>)self.tableContext;
    [privateContext deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

/**
 * Section controller reload rows.Don't overwrite this method.
 * 刷新行 直接使用不要重写这个方法
 */
- (void)reloadRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object {
    ALAssertMainThread();
    ALParameterAssert(indexs != nil);
    NSUInteger section = self.section;
    NSMutableArray <NSIndexPath *> *indexPaths = [NSMutableArray arrayWithCapacity:indexs.count];
    [indexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:section];
        [indexPaths addObject:indexPath];
    }];
    [self al_beforeUpdateToObject:object];
    [self al_didUpdateToObject:object];
    id <ALTablePrivateContext> privateContext = (id <ALTablePrivateContext>)self.tableContext;
    [privateContext reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)updateHeightForRowsAtIndexs:(NSIndexSet *)indexs {
    ALAssertMainThread();
    ALParameterAssert(indexs != nil);
    if (self.sectionController.needCacheCellsHeight) {
        [indexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cellHeightMap removeObjectForKey:@(idx)];
        }];
    }
    id <ALTablePrivateContext> privateContext = (id <ALTablePrivateContext>)self.tableContext;
    [privateContext updateHeightForRows];
}

- (void)updateRowsWithUpdates:(dispatch_block_t)updates {
    ALAssertMainThread();
    ALParameterAssert(indexs != nil);
    id <ALTablePrivateContext> privateContext = (id <ALTablePrivateContext>)self.tableContext;
    [privateContext updateRowsWithUpdates:updates];
}

@end
