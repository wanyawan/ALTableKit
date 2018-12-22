//
//  ALTableAdapterUpdater.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <ALTableKit/ALTableAssert.h>
#import "ALTableAdapterUpdater.h"

@interface ALTableAdapterUpdater ()

@property (nonatomic, copy, nullable) ALTableReloadUpdateBlock reloadUpdates;

@property (nonatomic, strong) NSMutableArray<ALTableUpdaterCompletion> *completionBlocks;

//@property (nonatomic, assign, getter=hasQueuedReloadData) BOOL queuedReloadData;

@end

@implementation ALTableAdapterUpdater

- (instancetype)init {
    self = [super init];
    if (self) {
        _completionBlocks = [NSMutableArray new];
    }
    return self;
}

- (void)_queueUpdateWithTableView:(UITableView *)tableView {
    ALAssertMainThread();
    
    if (tableView == nil) {
        return;
    }
    
    __weak __typeof__(self) weakSelf = self;
    __weak __typeof__(tableView) weakTableView = tableView;
    
    // dispatch after a given amount of time to coalesce other updates and execute as one
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, self.coalescanceTime * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (weakSelf.state != ALTableBatchUpdateStateIdle) {
            return;
        }
        
        [weakSelf performReloadDataWithTableView:weakTableView];
//        to do
//        if (weakSelf.hasQueuedReloadData) {
//           [weakSelf performReloadDataWithTableView:weakTableView];
//        } else {
//            // to do performBatchUpdate
//        }
    });
}

- (void)performReloadDataWithTableView:(UITableView *)tableView {
    ALAssertMainThread();
    
    if (tableView == nil) {
        return;
    }
    
    void (^reloadUpdates)(void) = self.reloadUpdates;
    NSMutableArray *completionBlocks = [self.completionBlocks mutableCopy];
    
    [self cleanStateBeforeUpdates];
    
    // item updates must not send mutations to the collection view while we are reloading
    self.state = ALTableBatchUpdateStateExecutingBatchUpdateBlock;
    
    if (reloadUpdates) {
        reloadUpdates();
    }
    
    self.state = ALTableBatchUpdateStateExecutedBatchUpdateBlock;
    
    [self _cleanStateAfterUpdates];
    
    [tableView reloadData];
    
    for (ALTableUpdaterCompletion block in completionBlocks) {
        block(YES);
    }
    
    self.state = ALTableBatchUpdateStateIdle;
}

- (void)cleanStateBeforeUpdates {
    self.reloadUpdates = nil;
    [self.completionBlocks removeAllObjects];
}

- (void)_cleanStateAfterUpdates {

}

- (void)reloadDataWithTableView:(UITableView *)tableView
              reloadUpdateBlock:(ALTableReloadUpdateBlock)reloadUpdateBlock
                     completion:(nullable ALTableUpdaterCompletion)completion {
    ALAssertMainThread();
    ALParameterAssert(tableView != nil);
    ALParameterAssert(reloadUpdateBlock != nil);
    
    ALTableUpdaterCompletion localCompletion = completion;
    if (localCompletion) {
        [self.completionBlocks addObject:localCompletion];
    }
    
    self.reloadUpdates = reloadUpdateBlock;
//    self.queuedReloadData = YES;
    [self _queueUpdateWithTableView:tableView];
}

- (void)reloadTableView:(UITableView *)tableView sections:(NSIndexSet *)sections rowAnimation:(UITableViewRowAnimation)rowAnimation {
    ALAssertMainThread();
    ALParameterAssert(tableView != nil);
    ALParameterAssert(sections != nil);
//    if (self.state == ALTableBatchUpdateStateExecutingBatchUpdateBlock && rowAnimation == UITableViewRowAnimationNone) {
//        [self.batchUpdates.sectionReloads addIndexes:sections];
//    } else {
        [tableView reloadSections:sections withRowAnimation:rowAnimation];
//    }
}

@end
