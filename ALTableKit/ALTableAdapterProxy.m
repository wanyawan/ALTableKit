//
//  ALTableAdapterProxy.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/6.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableAdapterProxy.h"
#import "ALTableAssert.h"

static BOOL isInterceptedSelector(SEL sel) {
    return (
            // UIScrollViewDelegate
            sel == @selector(scrollViewDidScroll:) ||
            sel == @selector(scrollViewWillBeginDragging:) ||
            sel == @selector(scrollViewDidEndDragging:willDecelerate:) ||
            sel == @selector(scrollViewDidEndDecelerating:) ||
            // UITableViewDelegate
            sel == @selector(tableView:didSelectRowAtIndexPath:) ||
            sel == @selector(tableView:didDeselectRowAtIndexPath:) ||
            sel == @selector(tableView:willDisplayCell:forRowAtIndexPath:) ||
            sel == @selector(tableView:willDisplayHeaderView:forSection:) ||
            sel == @selector(tableView:willDisplayFooterView:forSection:) ||
            sel == @selector(tableView:didEndDisplayingCell:forRowAtIndexPath:) ||
            sel == @selector(tableView:didEndDisplayingHeaderView:forSection:) ||
            sel == @selector(tableView:didEndDisplayingFooterView:forSection:)
            );
}

@interface ALTableAdapterProxy () {
    __weak id _tableViewDelegateTarget;
    __weak id _scrollViewDelegateTarget;
    __weak ALTableAdapter *_interceptor;
}

@end

@implementation ALTableAdapterProxy

- (instancetype)initWithTableViewDelegateTarget:(nullable id<UITableViewDelegate>)tableViewDelegateTarget
                       scrollViewDelegateTarget:(nullable id<UIScrollViewDelegate>)scrollViewDelegateTarget
                                    interceptor:(ALTableAdapter *)interceptor {
    ALParameterAssert(interceptor == nil);
    if (self) {
        _tableViewDelegateTarget = tableViewDelegateTarget;
        _scrollViewDelegateTarget = scrollViewDelegateTarget;
        _interceptor = interceptor;
    }
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return isInterceptedSelector(aSelector)
    || [_tableViewDelegateTarget respondsToSelector:aSelector]
    || [_scrollViewDelegateTarget respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (isInterceptedSelector(aSelector)) {
        return _interceptor;
    }
    return [_scrollViewDelegateTarget respondsToSelector:aSelector] ? _scrollViewDelegateTarget : _tableViewDelegateTarget;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

@end
