//
//  ComplexModel.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/29.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ComplexModel.h"

@implementation ComplexModel

- (id<NSObject>)diffIdentifier {
    return self;
}

- (BOOL)isEqualToDiffableObject:(id<ALTableDiffable>)object {
    return NO;
}

@end
