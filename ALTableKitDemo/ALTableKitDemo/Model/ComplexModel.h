//
//  ComplexModel.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/29.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ALTableKit/ALTableDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComplexModel : NSObject <ALTableDiffable>

@property (nonatomic, assign) BOOL showSectionRow;

@end

NS_ASSUME_NONNULL_END
