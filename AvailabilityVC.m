//
//  AvailabilityVC.m
//  CoreDataDemo
//
//  Created by David Rogers on 2/10/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "AvailabilityVC.h"
#import "AppDelegate.h"
#import "Reservation.h"

@interface AvailabilityVC ()

@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hotelSegmControl;
@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation AvailabilityVC

- (void)viewDidLoad {
    [super viewDidLoad];
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  self.context = appDelegate.managedObjectContext;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)checkAvailability:(id)sender {
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  
  NSString *selectedHotel = [self.hotelSegmControl titleForSegmentAtIndex:self.hotelSegmControl.selectedSegmentIndex];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.hotel.name MATCHES %@", selectedHotel];
  
  fetchRequest.predicate = predicate;
  
  NSFetchRequest *reservationFetch = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  
  NSPredicate *reservationPredicate = [NSPredicate predicateWithFormat:@"room.hotel.name MATCHES %@ AND startDate >= %@ OR endDate <= %@", selectedHotel, self.startDatePicker.date, self.endDatePicker.date];
  
  reservationFetch.predicate = reservationPredicate;
  NSError *fetchError;
  
  NSArray *results = [self.context executeFetchRequest:reservationFetch error:&fetchError];
  
  NSMutableArray *rooms = [NSMutableArray new];
  for (Reservation *reservation in results) {
    [rooms addObject:reservation.room];
  }
  
  NSFetchRequest *anotherFetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Room"];
    
  NSPredicate *roomsPredicate = [NSPredicate predicateWithFormat:@"hotel.name MATCHES %@ AND NOT (self IN %@)", selectedHotel, rooms];
  anotherFetchRequest.predicate = roomsPredicate;
  NSError *finalError;
  NSArray *finalResults = [self.context executeFetchRequest:anotherFetchRequest error:&finalError];
  if (finalError) {
    NSLog(@"%@",finalError.localizedDescription);
  }
    
  NSLog(@"results : %lu",(unsigned long)finalResults.count);
  
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
