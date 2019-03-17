//
//  ALTableSectionMap.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <ALTableKit/ALTableDiffable.h>
#import <ALTableKit/ALTableAssert.h>
#import "ALTableSectionMap.h"
#import "ALTableSectionControllerInternal.h"

@interface ALTableSectionMap ()

@property (nonatomic, strong, readonly, nonnull) NSMapTable<id, ALTableSectionController *> *objectToSectionControllerMap;
@property (nonatomic, strong, readonly, nonnull) NSMapTable<ALTableSectionController *, NSNumber *> *sectionControllerToSectionMap;
@property (nonatomic, strong, nonnull) NSMutableArray *mObjects;

@end

@implementation ALTableSectionMap

- (instancetype)init {
    self = [super init];
    if (self) {
        NSPointerFunctions *functions = [NSPointerFunctions pointerFunctionsWithOptions:NSPointerFunctionsStrongMemory];
        functions.hashFunction = ALTableIdentifierHash;
        functions.isEqualFunction = ALTableIsEqual;
        NSPointerFunctions *valueFunctions = [NSPointerFunctions pointerFunctionsWithOptions:NSPointerFunctionsStrongMemory];
        _objectToSectionControllerMap = [[NSMapTable alloc]initWithKeyPointerFunctions:functions valuePointerFunctions:valueFunctions capacity:0];
        _sectionControllerToSectionMap = [[NSMapTable alloc] initWithKeyOptions:NSMapTableStrongMemory | NSMapTableObjectPointerPersonality
                                                                   valueOptions:NSMapTableStrongMemory
                                                                       capacity:0];
        _mObjects = [NSMutableArray new];
    }
    return self;
}

- (NSArray *)objects {
    return [self.mObjects copy];
}

- (nullable ALTableSectionController *)sectionControllerForObject:(id)object {
    return [self.objectToSectionControllerMap objectForKey:object];
}

- (nullable ALTableSectionController *)sectionControllerForSection:(NSUInteger)section {
    return [self.objectToSectionControllerMap objectForKey:[self objectForSection:section]];
}

- (NSInteger)sectionForSectionController:(id)sectionController {
    NSNumber *index = [self.sectionControllerToSectionMap objectForKey:sectionController];
    return index != nil ? [index integerValue] : NSNotFound;
}

- (NSInteger)sectionForObject:(id)object {
    id sectionController = [self sectionControllerForObject:object];
    if (sectionController == nil) {
        return NSNotFound;
    } else {
        return [self sectionForSectionController:sectionController];
    }
}

- (nullable id)objectForSection:(NSUInteger)section {
    NSArray *objects = self.mObjects;
    if (section < objects.count) {
        return objects[section];
    } else {
        return nil;
    }
}

- (void)updateWithObjects:(NSArray *)objects sectionControllers:(NSArray *)sectionControllers {
    ALParameterAssert(objects.count == sectionControllers.count);
    
    [self reset];
    
    self.mObjects = [objects mutableCopy];
    
    id firstObject = objects.firstObject;
    id lastObject = objects.lastObject;
    
    [objects enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        ALTableSectionController *sectionController = sectionControllers[idx];
        
        // set the index of the list for easy reverse lookup
        [self.sectionControllerToSectionMap setObject:@(idx) forKey:sectionController];
        [self.objectToSectionControllerMap setObject:sectionController forKey:object];
        
        sectionController.isFirstSection = (object == firstObject);
        sectionController.isLastSection = (object == lastObject);
        sectionController.section = idx;
    }];
}

- (void)updateObject:(id)object {
    ALParameterAssert(object != nil);
    const NSInteger section = [self sectionForObject:object];
    id sectionController = [self sectionControllerForObject:object];
    [self.sectionControllerToSectionMap setObject:@(section) forKey:sectionController];
    [self.objectToSectionControllerMap setObject:sectionController forKey:object];
    self.mObjects[section] = object;
}

- (void)reset {
    [self enumerateUsingBlock:^(id  _Nonnull object, ALTableSectionController * _Nonnull sectionController, NSInteger section, BOOL * _Nonnull stop) {
        sectionController.section = NSNotFound;
        sectionController.isFirstSection = NO;
        sectionController.isLastSection = NO;
    }];
    [self.sectionControllerToSectionMap removeAllObjects];
    [self.objectToSectionControllerMap removeAllObjects];
}

- (void)enumerateUsingBlock:(void (^)(id object, ALTableSectionController *sectionController, NSInteger section, BOOL *stop))block {
    ALParameterAssert(block != nil);
    
    BOOL stop = NO;
    NSArray *objects = self.objects;
    for (NSUInteger section = 0; section < objects.count; section++) {
        id object = objects[section];
        ALTableSectionController *sectionController = [self sectionControllerForObject:object];
        block(object, sectionController, section, &stop);
        if (stop) {
            break;
        }
    }
}

@end
