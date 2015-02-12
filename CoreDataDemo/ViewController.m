//
//  ViewController.m
//  CoreDataDemo
//
//  Created by David Rogers on 2/9/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "RoomsTVC.h"
#import "HotelService.h"

@interface ViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *hotels;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  self.tableView.dataSource = self;
 // self.tableView.delegate = self;
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSManagedObjectContext *context = appDelegate.managedObjectContext;
  
//  NSManagedObjectContext *MOM = [context.persistentStoreCoordinator.managedObjectModel];
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
  
  NSError *fetchError;
  
  NSArray *results = [context executeFetchRequest:fetchRequest error:&fetchError];
  if (!fetchError) {
    self.hotels = results;
    [self.tableView reloadData];
  }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.hotels) {
    return self.hotels.count;
  
  } else {
    return 0;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HOTEL_CELL" forIndexPath:indexPath];
  Hotel *hotel = self.hotels[indexPath.row];
  cell.textLabel.text = hotel.name;
  return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"ROOMS_TVC"]) {
    RoomsTVC *destinationVC = segue.destinationViewController;
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    Hotel *hotel = self.hotels[indexPath.row];
    destinationVC.selectedHotel = hotel;
  }
  
  
  
  
}



//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//  
//  RoomsTVC *roomsTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ROOMS_TVC"];
//  
//  ViewController *hotel = self.hotels[indexPath.row];
//  NSArray *rooms = [hotel.rooms allObjects];
//  
//  
//  roomsTVC.rooms = rooms;
//  
//  [self.navigationController pushViewController:roomsTVC animated:true];
//  
//}



- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
