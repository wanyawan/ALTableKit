//
//  ALTableSectionProvider.m
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <ALTableKit/ALTableAssert.h>
#import "ALTableSectionProviderInternal.h"
#import "ALTableSectionController+PrivateMethods.h"
#import "ALTablePrivateContext.h"

@implementation ALTableSectionProvider

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

- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndex:(NSUInteger)index {}

- (nullable NSArray<UITableViewRowAction *> *)editActionsForRowAtIndex:(NSUInteger)index NS_AVAILABLE_IOS(8_0) {
    return nil;
}

/**
 * Section provider insert rows.Don't overwrite this method.
 * 插入行直接使用不要重写这个方法
 */
- (void)insertRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object {
    NSUInteger section = self.sectionController.section;
    NSMutableArray <NSIndexPath *> *indexPaths = [NSMutableArray arrayWithCapacity:indexs.count];
    [indexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger row = self.firstCellAbsoluteIndex + idx;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
        [indexPaths addObject:indexPath];
    }];
    [self.sectionController al_beforeUpdateToObject:object];
    [self.sectionController al_didUpdateToObject:object];
    id <ALTablePrivateContext> privateContext = (id <ALTablePrivateContext>)self.tableContext;
    [privateContext insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

/**
 * Section provider delete rows.Don't overwrite this method.
 * 删除行 直接使用不要重写这个方法
 */
- (void)deleteRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object {
    NSUInteger section = self.sectionController.section;
    NSMutableArray <NSIndexPath *> *indexPaths = [NSMutableArray arrayWithCapacity:indexs.count];
    [indexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger row = self.firstCellAbsoluteIndex + idx;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
        [indexPaths addObject:indexPath];
    }];
    [self.sectionController al_beforeUpdateToObject:object];
    [self.sectionController al_didUpdateToObject:object];
    id <ALTablePrivateContext> privateContext = (id <ALTablePrivateContext>)self.tableContext;
    [privateContext deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

/**
 * Section provider reload rows.Don't overwrite this method.
 * 刷新行 直接使用不要重写这个方法
 */
- (void)reloadRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object {
    NSUInteger section = self.sectionController.section;
    NSMutableArray <NSIndexPath *> *indexPaths = [NSMutableArray arrayWithCapacity:indexs.count];
    [indexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger row = self.firstCellAbsoluteIndex + idx;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
        [indexPaths addObject:indexPath];
    }];
    [self.sectionController al_beforeUpdateToObject:object];
    [self.sectionController al_didUpdateToObject:object];
    id <ALTablePrivateContext> privateContext = (id <ALTablePrivateContext>)self.tableContext;
    [privateContext reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

@end
