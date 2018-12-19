//
//  ALTableDiffable.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ALTableDiffable <NSObject>
/**
 Returns a key that uniquely identifies the object.
 返回一个对象用于判断是否相同
 */
- (nonnull id<NSObject>)diffIdentifier;

/**
 Returns whether the receiver and a given object are equal.
 对比两个对象是否相同
 */
- (BOOL)isEqualToDiffableObject:(nullable id<ALTableDiffable>)object;

@end

static BOOL ALTableIsEqual(const void *a, const void *b, NSUInteger (*size)(const void *item)) {
    const id<ALTableDiffable, NSObject> left = (__bridge id<ALTableDiffable, NSObject>)a;
    const id<ALTableDiffable, NSObject> right = (__bridge id<ALTableDiffable, NSObject>)b;
    return [left class] == [right class]
    && [[left diffIdentifier] isEqual:[right diffIdentifier]];
}

static NSUInteger ALTableIdentifierHash(const void *item, NSUInteger (*size)(const void *item)) {
    return [[(__bridge id<ALTableDiffable>)item diffIdentifier] hash];
}

NS_ASSUME_NONNULL_END
