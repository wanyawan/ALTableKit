//
//  ALTableAdapter+HeightCache.h
//  xcf-iphone
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTableAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALTableAdapter (HeightCache)

/**
 Return the cell height at indexPath.
 返回indexPath位置 HeaderView的高度
 */
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Return the HeaderView height at indexPath.
 返回indexPath位置 HeaderView的高度
 */
- (CGFloat)heightForHeaderViewAtIndexPath:(NSIndexPath *)indexPath;

/**
 Return the cell FooterView at indexPath.
 返回indexPath位置 FooterView的高度
 */
- (CGFloat)heightForFooterViewAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
