//
// Created by Diego Chohfi on 11/21/13.
// Copyright (c) 2013 Diego Chohfi. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol DCFetchedResultsControllerDataSourceDelegate

- (void) configureCell: (UITableViewCell *) tableViewCell
            withObject: (id) object;

@end


@interface DCFetchedResultsControllerDataSource : NSObject<UITableViewDataSource, NSFetchedResultsControllerDelegate>

- (id) initWithTableView: (UITableView *) tableView
         reuseIdentifier: (NSString *) reuseIdentifier
                delegate: (id<DCFetchedResultsControllerDataSourceDelegate>) delegate
fetchedResultsController: (NSFetchedResultsController *) fetchedResultsController;

@end