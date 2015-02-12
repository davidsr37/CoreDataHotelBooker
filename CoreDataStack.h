//
//  CoreDataStack.h
//  CoreDataDemo
//
//  Created by David Rogers on 2/11/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h> 
#import "Hotel.h"
#import "Room.h"

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(instancetype) initForTesting;

@end
