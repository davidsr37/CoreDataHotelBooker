//
//  HotelService.m
//  CoreDataDemo
//
//  Created by David Rogers on 2/11/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "HotelService.h"


@implementation HotelService

+(id)sharedService {
  static HotelService *mySharedService = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    mySharedService = [self new];
  });
  
  return mySharedService;
}

-(instancetype)init {
  self = [super init];
  if (self) {
    self.coreDataStack = [CoreDataStack new];
  
  }
  
  return self;
  
}

-(instancetype)initForTesting {
  self = [super init];
  if (self) {
    self.coreDataStack = [[CoreDataStack alloc] initForTesting];
  }
  return self;
}

-(Reservation *)bookReservationForGuest:(Guest *)guest ForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  reservation.startDate = startDate;
  reservation.endDate = endDate;
  reservation.room = room;
  reservation.guest = guest;
  
  NSError *saveError;
  [self.coreDataStack.managedObjectContext save:&saveError];
  if (!saveError) {
    return reservation;
    
  } else {
    return nil;
  }
}

@end
