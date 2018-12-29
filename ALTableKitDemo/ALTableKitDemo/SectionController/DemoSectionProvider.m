//
//  DemoSectionProvider.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/29.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "DemoSectionProvider.h"
#import "ComplexModel.h"
#import "DemoTableViewCell.h"

@interface DemoSectionProvider ()

@property (nonatomic, strong) ComplexModel *model;

@end

@implementation DemoSectionProvider

- (void)didUpdateToObject:(id)object {
    _model = object;
}

- (NSInteger)numberOfRows {
    return 1;
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index {
    return 50;
}

- (UITableViewCell *)cellForRowAtIndex:(NSInteger)index {
    DemoTableViewCell *cell = [self.tableContext dequeueReusableCellOfClass:[DemoTableViewCell class]
                                                       forSectionController:self.sectionController];
    cell.textLabel.text = [NSString stringWithFormat:@"cell section %zd index %zd", self.sectionController.section, index];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didSelectRowAtIndex:(NSInteger)index {
    
}

@end


@implementation DemoFirstSectionProvider : DemoSectionProvider

@end

@implementation DemoSecondSectionProvider : DemoSectionProvider

- (NSInteger)numberOfRows {
    return self.model.showSectionRow ? 1 : 0;
}

@end

@implementation DemoThirdSectionProvider : DemoSectionProvider

@end

