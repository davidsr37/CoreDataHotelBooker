//
//  SetReservationVC.m
//  CoreDataDemo
//
//  Created by David Rogers on 2/10/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "SetReservationVC.h"

@interface SetReservationVC ()

@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;

@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;

//@property (weak, nonatomic) IBOutlet UIButton *bookItButton;

@end

@implementation SetReservationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)bookItButton:(id)sender {
  
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.selectedRoom.managedObjectContext];
  
  reservation.startDate = self.startDatePicker.date;
  reservation.endDate = self.endDatePicker.date;
  reservation.room = self.selectedRoom;
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.selectedRoom.managedObjectContext];
  reservation.guest = guest;
  
  NSLog(@"%lu", (unsigned long) self.selectedRoom.reservations.count);
  
  
  NSerror *saveError;
  [self.selectedRoom.managedObjectContext save: &saveError]
  
  if (saveError) {
    NSLog(@" %@", saveError.localizedDescription);
  }
  
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
