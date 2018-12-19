//
//  ALTableAdapter.m
//  ALTableKit
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableAdapterInternal.h"
#import "ALTableSectionControllerInternal.h"
#import "ALTableContext.h"
#import "ALTableSectionMap.h"
#import "ALTableDataSource.h"
#import "ALTableAssert.h"
#import "ALTableAdapterProxy.h"
#import "ALTableDisplayHandler.h"

static NSArray *objectsWithDuplicateIdentifiersRemoved(NSArray<id<ALTableDiffable>> *objects) {
    if (objects == nil) {
        return nil;
    }
    NSMapTable *identifierMap = [NSMapTable strongToStrongObjectsMapTable];
    NSMutableArray *uniqueObjects = [NSMutableArray new];
    for (id<ALTableDiffable> object in objects) {
        id diffIdentifier = [object diffIdentifier];
        id previousObject = [identifierMap objectForKey:diffIdentifier];
        if (diffIdentifier != nil
            && previousObject == nil) {
            [identifierMap setObject:object forKey:diffIdentifier];
            [uniqueObjects addObject:object];
        } else {
            ALFailAssert(@"Duplicate identifier %@ for object %@ with object %@", diffIdentifier, object, previousObject);
        }
    }
    return uniqueObjects;
}

@implementation ALTableAdapter
{
    NSMapTable<UIView *, ALTableSectionController *> *_viewSectionControllerMap;
}

#pragma mark -- Life Cycle

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _viewController = viewController;
        _sectionMap = [ALTableSectionMap new];
        _updater = [ALTableAdapterUpdater new];
        _displayHandler = [ALTableDisplayHandler new];
        _viewSectionControllerMap = [NSMapTable mapTableWithKeyOptions:NSMapTableObjectPointerPersonality | NSMapTableStrongMemory
                                                          valueOptions:NSMapTableStrongMemory];
    }
    return self;
}

- (void)dealloc {
    // on iOS 9 setting the dataSource has side effects that can invalidate the layout and seg fault
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        _tableView.dataSource = nil;
        _tableView.delegate = nil;
    }
    
    [self.sectionMap reset];
}


#pragma mark -- Getters & Setters

- (void)setTableView:(UITableView *)tableView {
    if (_tableView != tableView || _tableView.dataSource != self) {

        static NSMapTable<UITableView *, ALTableAdapter *> *globalTableViewAdapterMap = nil;
        if (globalTableViewAdapterMap == nil) {
            globalTableViewAdapterMap = [NSMapTable weakToWeakObjectsMapTable];
        }
        [globalTableViewAdapterMap removeObjectForKey:_tableView];
        [[globalTableViewAdapterMap objectForKey:tableView] setTableView:nil];
        [globalTableViewAdapterMap setObject:self forKey:tableView];
        
        _registeredCellClasses = [NSMutableSet new];
        _registeredNibNames = [NSMutableSet new];
        _registeredHeaderFooterViewIdentifiers = [NSMutableSet new];
        _registeredHeaderFooterViewNibNames = [NSMutableSet new];
        _tableView = tableView;
        _tableView.dataSource = self;

        [self _updateTableViewDelegate];
        [self _updateAfterPublicSettingsChange];
    }
}

-(void)setDataSource:(id<ALTableDataSource>)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        [self _updateAfterPublicSettingsChange];
    }
}

- (void)setScrollViewDelegate:(id<UIScrollViewDelegate>)scrollViewDelegate {
    if (_scrollViewDelegate != scrollViewDelegate) {
        _scrollViewDelegate = scrollViewDelegate;
        [self _createProxyAndUpdateCollectionViewDelegate];
    }
}

- (void)setTableViewDelegate:(id<UITableViewDelegate>)tableViewDelegate {
    if (_tableViewDelegate != tableViewDelegate) {
        _tableViewDelegate = tableViewDelegate;
        [self _createProxyAndUpdateCollectionViewDelegate];
    }
}

#pragma mark -- Private Methods

- (void)_updateAfterPublicSettingsChange {
    id<ALTableDataSource> dataSource = _dataSource;
    if (_tableView != nil && dataSource != nil) {
        NSArray *uniqueObjects = objectsWithDuplicateIdentifiersRemoved([dataSource objectsForTableAdapter:self]);
        [self _updateObjects:uniqueObjects dataSource:dataSource];
    }
}

- (void)_createProxyAndUpdateCollectionViewDelegate {
    _tableView.delegate = nil;
    
    self.delegateProxy = [[ALTableAdapterProxy alloc] initWithTableViewDelegateTarget:_tableViewDelegate
                                                             scrollViewDelegateTarget:_scrollViewDelegate
                                                                          interceptor:self];
    [self _updateTableViewDelegate];
}

- (void)_updateTableViewDelegate {
    _tableView.delegate = self.delegateProxy ? :self;
}

#pragma mark - List Items & Sections

- (NSArray<ALTableSectionController *> *)visibleSectionControllers {
    return [[self.displayHandler visibleTableSections] allObjects];
}

- (void)mapView:(UIView *)view toSectionController:(ALTableSectionController *)sectionController {
    ALAssertMainThread();
    ALParameterAssert(view != nil);
    ALParameterAssert(sectionController != nil);
    [_viewSectionControllerMap setObject:sectionController forKey:view];
}

- (nullable ALTableSectionController *)sectionControllerForView:(UIView *)view {
    ALAssertMainThread();
    ALParameterAssert(view != nil);
    return [_viewSectionControllerMap objectForKey:view];
}

- (void)removeMapForView:(UIView *)view {
    ALAssertMainThread();
    ALParameterAssert(view != nil);
    [_viewSectionControllerMap removeObjectForKey:view];
}

- (nullable ALTableSectionController *)sectionControllerForSection:(NSInteger)section {
    ALAssertMainThread();
    return [self.sectionMap sectionControllerForSection:section];
}

- (NSInteger)sectionForSectionController:(ALTableSectionController *)sectionController {
    ALAssertMainThread();
    ALParameterAssert(sectionController != nil);
    return [self.sectionMap sectionForSectionController:sectionController];
}

- (ALTableSectionController *)sectionControllerForObject:(id)object {
    ALAssertMainThread();
    ALParameterAssert(object != nil);
    return [self.sectionMap sectionControllerForObject:object];
}

- (id)objectForSectionController:(ALTableSectionController *)sectionController {
    ALAssertMainThread();
    ALParameterAssert(sectionController != nil);
    const NSInteger section = [self.sectionMap sectionForSectionController:sectionController];
    return [self.sectionMap objectForSection:section];
}

- (id)objectAtSection:(NSInteger)section {
    ALAssertMainThread();
    return [self.sectionMap objectForSection:section];
}

- (NSInteger)sectionForObject:(id)item {
    ALAssertMainThread();
    ALParameterAssert(item != nil);
    return [self.sectionMap sectionForObject:item];
}

- (NSArray *)objects {
    ALAssertMainThread();
    return self.sectionMap.objects;
}

#pragma mark - Public API

- (void)reloadDataWithCompletion:(nullable ALTableUpdaterCompletion)completion {
    id<ALTableDataSource> dataSource = self.dataSource;
    UITableView *tableView = self.tableView;
    if (dataSource == nil || tableView == nil) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    NSArray *uniqueObjects = objectsWithDuplicateIdentifiersRemoved([dataSource objectsForTableAdapter:self]);
    
    __weak __typeof__(self) weakSelf = self;
    [self.updater reloadDataWithTableView:tableView reloadUpdateBlock:^{
        // purge all section controllers from the item map so that they are regenerated
        [weakSelf.sectionMap reset];
        [weakSelf _updateObjects:uniqueObjects dataSource:dataSource];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)reloadObjects:(NSArray *)objects rowAnimation:(UITableViewRowAnimation)rowAnimation{
    NSMutableIndexSet *sections = [NSMutableIndexSet new];
//    // use the item map based on whether or not we're in an update block
    ALTableSectionMap *map = self.sectionMap;
    for (id object in objects) {
        // look up the item using the map's lookup function. might not be the same item
        const NSInteger section = [map sectionForObject:object];
        const BOOL notFound = section == NSNotFound;
        if (notFound) {
            continue;
        }
        [sections addIndex:section];

        // reverse lookup the item using the section. if the pointer has changed the trigger update events and swap items
        if (object != [map objectForSection:section]) {
            [map updateObject:object];
            ALTableSectionController *sectionController= [map sectionControllerForSection:section];
            [sectionController beforeUpdateToObject:object];
            [sectionController didUpdateToObject:object];
        }
    }
    UITableView *tableView = self.tableView;
    ALAssert(tableView != nil, @"Tried to reload the adapter without a table view");
    [self.updater reloadTableView:tableView sections:sections rowAnimation:rowAnimation];
}

#pragma mark - Private API

// this method is what updates the "source of truth"
// this should only be called just before the table view is updated
- (void)_updateObjects:(NSArray *)objects dataSource:(id<ALTableDataSource>)dataSource {
    NSMutableArray<ALTableSectionController *> *sectionControllers = [NSMutableArray new];
    NSMutableArray *validObjects = [NSMutableArray new];
    
    ALTableSectionMap *map = self.sectionMap;
    
    NSMutableSet *updatedObjects = [NSMutableSet new];
    
    for (id object in objects) {
        ALTableSectionController *sectionController = [map sectionControllerForObject:object];
        if (sectionController == nil) {
            sectionController = [dataSource tableAdapter:self sectionControllerForObject:object];
        }
        
        if (sectionController == nil) {
            NSLog(@"WARNING: Ignoring nil section controller returned by data source %@ for object %@.",dataSource, object);
            continue;
        }
        
        sectionController.tableContext = self;
        sectionController.viewController = self.viewController;
        
        // check if the item has changed instances or is new
        const NSInteger oldSection = [map sectionForObject:object];
        if (oldSection == NSNotFound || [map objectForSection:oldSection] != object) {
            [updatedObjects addObject:object];
        }
        
        [sectionControllers addObject:sectionController];
        [validObjects addObject:object];
    }
    
#if DEBUG
        ALAssert([NSSet setWithArray:sectionControllers].count == sectionControllers.count,
                 @"Section controllers array is not filled with unique objects; section controllers are being reused");
#endif
    
        [map updateWithObjects:validObjects sectionControllers:sectionControllers];
        // now that the maps have been created and contexts are assigned, we consider the section controller "fully loaded"
        for (id object in updatedObjects) {
            ALTableSectionController *sectionController= [map sectionControllerForObject:object];
            [sectionController beforeUpdateToObject:object];
            [sectionController didUpdateToObject:object];
        }
        NSInteger itemCount = 0;
        for (ALTableSectionController *sectionController in sectionControllers) {
            itemCount += [sectionController numberOfRows];
        }
        [self _updateBackgroundViewShouldHide:itemCount > 0];
}

- (void)_updateBackgroundViewShouldHide:(BOOL)shouldHide {

    UIView *backgroundView = [self.dataSource emptyViewForTableAdapter:self];
    if (backgroundView != _tableView.backgroundView) {
        [_tableView.backgroundView removeFromSuperview];
        _tableView.backgroundView = nil;
        _tableView.backgroundView = backgroundView;
    }
    _tableView.backgroundView.hidden = shouldHide;
}

@end
