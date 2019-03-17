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

- (void)updateToObject:(id)object insertRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation;

- (void)updateToObject:(id)object deleteRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation;

- (void)updateToObject:(id)object reloadRowsAtIndexs:(NSIndexSet *)indexs withRowAnimation:(UITableViewRowAnimation)animation;

@end

NS_ASSUME_NONNULL_END
