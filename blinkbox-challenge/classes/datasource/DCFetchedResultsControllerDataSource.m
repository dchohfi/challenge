//
// Created by Diego Chohfi on 11/21/13.
// Copyright (c) 2013 Diego Chohfi. All rights reserved.
//


#import "DCFetchedResultsControllerDataSource.h"

@interface DCFetchedResultsControllerDataSource()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *reuseIdentifier;
@property (nonatomic, weak) id<DCFetchedResultsControllerDataSourceDelegate> delegate;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation DCFetchedResultsControllerDataSource

- (id) initWithTableView: (UITableView *) tableView
         reuseIdentifier: (NSString *) reuseIdentifier
                delegate: (id<DCFetchedResultsControllerDataSourceDelegate>) delegate
fetchedResultsController: (NSFetchedResultsController *) fetchedResultsController {
    self = [super init];
    if(self){
        self.delegate = delegate;
        self.tableView = tableView;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class]
               forCellReuseIdentifier:reuseIdentifier];
        self.reuseIdentifier = reuseIdentifier;
        self.fetchedResultsController = fetchedResultsController;
        [self setupFecthedResultsController];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return sectionInfo.numberOfObjects;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier
                                                            forIndexPath:indexPath];

    [self.delegate configureCell:cell withObject:object];
    return cell;
}
#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent: (NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}
- (void)controllerDidChangeContent: (NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}
- (void)controller:(NSFetchedResultsController*)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath*)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath*)newIndexPath {
    if (type == NSFetchedResultsChangeInsert) {
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
#pragma mark - private methods
- (void) setupFecthedResultsController {
    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:NULL];
    [self.tableView reloadData];
}
@end