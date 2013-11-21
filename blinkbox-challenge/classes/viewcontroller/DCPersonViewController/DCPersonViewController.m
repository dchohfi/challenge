//
//  DCPersonViewController.m
//  blinkbox-challenge
//
//  Created by Diego Chohfi on 11/21/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "DCPersonViewController.h"
#import "DCFetchedResultsControllerDataSource.h"
#import "DCPerson.h"
#import "UIImageView+WebCache.h"

@interface DCPersonViewController ()<DCFetchedResultsControllerDataSourceDelegate>

@property (nonatomic, strong) DCFetchedResultsControllerDataSource *dataSource;
@end

@implementation DCPersonViewController
#pragma mark - UIViewController
- (void)viewDidLoad {
    [self setupDataSourceForTableView];
}
#pragma mark - DCFetchedResultsControllerDataSourceDelegate
- (void)configureCell:(UITableViewCell *)tableViewCell withObject:(DCPerson *)person {
    tableViewCell.textLabel.text = person.firstName;
    NSURL *imageURL = person.imageUrl;
    [tableViewCell.imageView setImageWithURL:imageURL];
}
#pragma mark - private methods
- (void)setupDataSourceForTableView {
    self.dataSource = [[DCFetchedResultsControllerDataSource alloc] initWithTableView:self.tableView
                                                                      reuseIdentifier:@"PersonCell"
                                                                             delegate:self
                                                             fetchedResultsController:[DCPerson fetchedResultsController]];
}

@end
