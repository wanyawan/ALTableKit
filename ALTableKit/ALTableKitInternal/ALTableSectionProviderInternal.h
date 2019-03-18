//
//  ALTableSectionProviderInternal.h
//  ALTableKit
//
//  Created by Alex on 2018/12/22.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALTableSectionProvider.h"
#import "ALTablePrivateContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALTableSectionProvider ()

@property (nonatomic, assign, readwrite) NSUInteger sectionProviderIndex;

@property (nonatomic, assign, readwrite) NSUInteger firstCellAbsoluteIndex;

@property (nonatomic, weak, nullable, readwrite) UIViewController *viewController;

@property (nonatomic, weak, nullable, readwrite) id<ALTablePrivateContext> tableContext;

@property (nonatomic, weak, nullable, readwrite) ALTableComplexSectionController *sectionController;

@end

NS_ASSUME_NONNULL_END
