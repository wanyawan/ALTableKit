//
//  ALTableSectionProviderInternal.h
//  ALTableKit
//
//  Created by Alex on 2018/12/22.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALTableSectionProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALTableSectionProvider ()

@property (nonatomic, assign, readwrite) NSUInteger sectionProviderIndex;

@property (nonatomic, assign, readwrite) NSUInteger firstCellAbsoluteIndex;

@property (nonatomic, weak, nullable, readwrite) UIViewController *viewController;

@property (nonatomic, weak, nullable, readwrite) id<ALTableContext> tableContext;

@property (nonatomic, weak, nullable, readwrite) ALTableComplexSectionController *sectionController;

@end

NS_ASSUME_NONNULL_END
