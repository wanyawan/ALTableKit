//
//  SimpleModel.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/29.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "SimpleModel.h"

@implementation SimpleModel

- (id<NSObject>)diffIdentifier {
    return self;
}

- (BOOL)isEqualToDiffableObject:(id<ALTableDiffable>)object {
    return NO;
}

@end
