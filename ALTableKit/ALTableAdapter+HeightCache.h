//
//  ALTableAdapter+HeightCache.h
//  xcf-iphone
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ALTableKit/ALTableAdapter.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALTableAdapter (HeightCache)

/**
 Return the cell height at indexPath.
 返回indexPath位置 HeaderView的高度
 */
- (CGFloat)al_heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Return the HeaderView height at indexPath.
 返回indexPath位置 HeaderView的高度
 */
- (CGFloat)al_heightForHeaderViewAtIndexPath:(NSIndexPath *)indexPath;

/**
 Return the cell FooterView at indexPath.
 返回indexPath位置 FooterView的高度
 */
- (CGFloat)al_heightForFooterViewAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
