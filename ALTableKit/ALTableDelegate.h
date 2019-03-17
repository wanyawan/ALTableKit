//
//  ALTableDelegate.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/6.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALTableAdapter;

NS_ASSUME_NONNULL_BEGIN

/**
 ALTableAdapter to receive display events for a object when it is on screen.
 ALTableAdapter 接收object在屏幕上展示相关的事件
 */
@protocol ALTableDelegate <NSObject>

- (void)tableAdapter:(ALTableAdapter *)listAdapter willDisplayObject:(id)object atIndex:(NSUInteger)index;

- (void)tableAdapter:(ALTableAdapter *)listAdapter didEndDisplayingObject:(id)object atIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
