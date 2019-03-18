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
#import "ALTableAdapterInternal.h"

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

- (void)insertRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object {
    NSUInteger section = self.section;
    NSMutableArray <NSIndexPath *> *indexPaths = [NSMutableArray arrayWithCapacity:indexs.count];
    [indexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:section];
        [indexPaths addObject:indexPath];
    }];
    [self al_beforeUpdateToObject:object];
    [self al_didUpdateToObject:object];
    [self.tableContext insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)deleteRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object {
    NSUInteger section = self.section;
    NSMutableArray <NSIndexPath *> *indexPaths = [NSMutableArray arrayWithCapacity:indexs.count];
    [indexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:section];
        [indexPaths addObject:indexPath];
    }];
    [self al_beforeUpdateToObject:object];
    [self al_didUpdateToObject:object];
    [self.tableContext deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)reloadRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object {
    NSUInteger section = self.section;
    NSMutableArray <NSIndexPath *> *indexPaths = [NSMutableArray arrayWithCapacity:indexs.count];
    [indexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:section];
        [indexPaths addObject:indexPath];
    }];
    [self al_beforeUpdateToObject:object];
    [self al_didUpdateToObject:object];
    [self.tableContext reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

@end
