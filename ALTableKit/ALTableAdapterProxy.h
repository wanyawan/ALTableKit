//
//  ALTableAdapterProxy.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/6.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALTableAdapter;

NS_ASSUME_NONNULL_BEGIN

@interface ALTableAdapterProxy : NSObject 
/**
 负责将UITableViewDelegate UIScrollViewDelegate的事件 转发给ATTableAdapter与原本的delegate对象
 */
- (instancetype)initWithTableViewDelegateTarget:(nullable id<UITableViewDelegate>)tableViewDelegateTarget
                       scrollViewDelegateTarget:(nullable id<UIScrollViewDelegate>)scrollViewDelegateTarget
                                    interceptor:(ALTableAdapter *)interceptor;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
