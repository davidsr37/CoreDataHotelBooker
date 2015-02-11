//
//  CoreDataHelper.m
//  CoreDataDemo
//
//  Created by David Rogers on 2/9/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "CoreDataHelper.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "Room.h"
#import "Guest.h"
#import "Reservation.h"

@interface CoreDataHelper () <NSObject>

@property (strong, nonatomic) NSArray *hotels;
@property (strong, nonatomic) NSArray *rooms;

@end

@implementation CoreDataHelper


-(void) Hotels {

    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
  
    NSError *fetchError;
    
    NSArray *hotelResults = [context executeFetchRequest:fetchRequest error:&fetchError];
    if (!fetchError) {
      self.hotels = hotelResults;
    }
}

-(void) Rooms {
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSManagedObjectContext *context = appDelegate.managedObjectContext;
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
  
  NSError *fetchError;
  
  NSArray *roomResults = [context executeFetchRequest:fetchRequest error:&fetchError];
  if (!fetchError) {
    self.rooms = roomResults;
  
  }
  
}
@end
  

