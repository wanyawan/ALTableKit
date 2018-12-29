//
//  DemoComplexSectionController.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/29.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "DemoComplexSectionController.h"
#import "ComplexModel.h"
#import "DemoSectionProvider.h"

@implementation DemoComplexSectionController
{
    ComplexModel *_model;
}

- (void)didUpdateToObject:(id)object {
    _model = object;
}

- (NSArray<ALTableSectionProvider *> *)updateSectionProvidersWithObject:(id)object {
    DemoFirstSectionProvider *first = [DemoFirstSectionProvider new];
    DemoSecondSectionProvider *second = [DemoSecondSectionProvider new];
    DemoThirdSectionProvider *third = [DemoThirdSectionProvider new];
    return @[first, second, third];
}

@end
