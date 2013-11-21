//
//  DCPerson.m
//  blinkbox-challenge
//
//  Created by Diego Chohfi on 11/21/13.
//  Copyright (c) 2013 Diego Chohfi. All rights reserved.
//

#import "DCPerson.h"
#import "UIResponder+DCAdditions.h"


@implementation DCPerson

@dynamic age;
@dynamic firstName;
@dynamic image;
@dynamic lastName;

+ (instancetype)insertPersonWithData: (NSDictionary *) data
              inManagedObjectContext: (NSManagedObjectContext *) managedObjectContext {
    DCPerson *person = [NSEntityDescription insertNewObjectForEntityForName:self.entityName
                                                     inManagedObjectContext:managedObjectContext];
    person.firstName = data[@"firstName"];
    person.lastName = data[@"lastName"];
    person.age = @([data[@"age"] integerValue]);
    person.image = data[@"image"];
    return person;
}

- (NSURL *)imageUrl {
    return [NSURL URLWithString:self.image];
}

+ (NSString *) entityName {
    return @"Person";
}

+ (NSFetchedResultsController *) fetchedResultsController {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES]];

    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                               managedObjectContext:[UIResponder persistentStoreHelper].managedObjectContext
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}

@end
