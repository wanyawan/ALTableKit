//
//  ALTableSectionEdit.h
//  ALTableKit
//
//  Created by Alex on 2019/3/15.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ALTableSectionEdit <NSObject>

- (void)insertRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object;

- (void)deleteRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object;

- (void)reloadRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation updateToObject:(id)object;

@end

NS_ASSUME_NONNULL_END
