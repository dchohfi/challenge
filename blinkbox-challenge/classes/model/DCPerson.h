//
//  DCPerson.h
//  blinkbox-challenge
//
//  Created by Diego Chohfi on 11/21/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DCPerson : NSManagedObject

@property (nonatomic, retain) NSNumber *age;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, readonly) NSURL *imageUrl;

+ (instancetype)insertPersonWithData: (NSDictionary *) data
              inManagedObjectContext: (NSManagedObjectContext *) managedObjectContext;

+ (NSFetchedResultsController *) fetchedResultsController;

@end
