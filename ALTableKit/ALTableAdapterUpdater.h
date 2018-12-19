//
//  ALTableAdapterUpdater.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, ALTableBatchUpdateState) {
    ALTableBatchUpdateStateIdle,
    ALTableBatchUpdateStateQueuedBatchUpdate,
    ALTableBatchUpdateStateExecutingBatchUpdateBlock,
    ALTableBatchUpdateStateExecutedBatchUpdateBlock,
};

typedef void (^ALTableReloadUpdateBlock)(void);

typedef void (^ALTableUpdaterCompletion)(BOOL finished);

/**
 It is an out-of-box updater for `ALTableAdapter` objects to use.
 ALTableAdapterUpdater用于更新ALTableAdapter
 */
@interface ALTableAdapterUpdater : NSObject

/**
 Time, in seconds, to wait and coalesce batch updates. Default is 0.
 在一段时间内，如果有其他的数据也发生更新则一起更新UI 默认为0
 */
@property (nonatomic, assign) NSTimeInterval coalescanceTime;

@property (nonatomic, assign) ALTableBatchUpdateState state;

- (void)reloadDataWithTableView:(UITableView *)tableView
              reloadUpdateBlock:(ALTableReloadUpdateBlock)reloadUpdateBlock
                     completion:(nullable ALTableUpdaterCompletion)completion;

- (void)reloadTableView:(UITableView *)tableView sections:(NSIndexSet *)sections rowAnimation:(UITableViewRowAnimation)rowAnimation;

@end

NS_ASSUME_NONNULL_END
