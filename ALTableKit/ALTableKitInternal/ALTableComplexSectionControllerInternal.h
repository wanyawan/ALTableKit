//
//  ALTableComplexSectionControllerInternal.h
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALTableComplexSectionController.h"
#import "ALTableComplexSectionControllerIndexMap.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALTableComplexSectionController ()

@property (nonatomic, strong, nullable, readwrite) NSNumber *totalOfRows;

@property (nonatomic, strong, readwrite) ALTableComplexSectionControllerIndexMap *indexMap;

@property (nonatomic, strong, readwrite) NSArray <ALTableSectionProvider *> *sectionProviders;

@end

NS_ASSUME_NONNULL_END
