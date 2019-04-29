//
//  ALTableEditContext.h
//  ALTableKit
//
//  Created by Alex on 2019/3/18.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ALTablePrivateContext <ALTableContext>

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

- (void)updateHeightForRows;

- (void)updateRowsWithUpdates:(dispatch_block_t)updates;

@end

NS_ASSUME_NONNULL_END
