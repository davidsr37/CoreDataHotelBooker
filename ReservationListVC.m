//
//  ReservationListVC.m
//  CoreDataDemo
//
//  Created by David Rogers on 2/11/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "ReservationListVC.h"
#import "HotelService.h"
#import "SetReservationVC.h"

@interface ReservationListVC () <NSFetchedResultsControllerDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ReservationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
  NSManagedObjectContext *context = [[HotelService sharedService] coreDataStack].managedObjectContext;
  
  NSFetchRequest *fetchrequest = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
  
  NSPredicate *predicate =[NSPredicate predicateWithFormat:@"room == %@", self.selectedRoom];
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:true];
  
  fetchrequest.predicate = predicate;
  fetchrequest.sortDescriptors = @[sortDescriptor];
  self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchrequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
  self.fetchedResultsController.delegate = self;
  self.tableView.dataSource = self;
  NSError *fetchError;
  [self.fetchedResultsController performFetch:&fetchError];
  if (fetchError) {
    NSLog(@" %@", fetchError);
  }
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
  
  switch (type) {
    case NSFetchedResultsChangeInsert:
      [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeUpdate:
      [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath: indexPath];
      break;
    
    case NSFetchedResultsChangeMove:
      [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    default:
      break;
  }
  
  
  
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath: (NSIndexPath*)indexPath {
  
  Reservation *reservation = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = [NSString stringWithFormat:@" room: %@", reservation.room.number];
  
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [[self.fetchedResultsController sections] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  NSArray *sections = [self.fetchedResultsController sections];
  id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
  return [sectionInfo numberOfObjects];
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RESERVATIONS_CELL" forIndexPath:indexPath];
  [self configureCell:cell atIndexPath:indexPath];
  return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"ADD_RESERVATION"]) {
    SetReservationVC *destinationVC = segue.destinationViewController;
    destinationVC.selectedRoom = self.selectedRoom;
  }
  
  
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
