//
//  RoomsTVC.m
//  CoreDataDemo
//
//  Created by David Rogers on 2/9/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import "RoomsTVC.h"
//#import "AppDelegate.h"
//#import "Hotel.h"
#import "Room.h"
//#import "CoreDataHelper.h"
#import "SetReservationVC.h"

@interface RoomsTVC () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *rooms;

@end

@implementation RoomsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
  self.rooms = self.selectedHotel.rooms.allObjects;
  
  self.tableView.dataSource = self;
  
  
//  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//  NSManagedObjectContext *context = appDelegate.managedObjectContext;
//  
//  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
//  
//    NSError *fetchError;
//  
//  NSArray *results = [context executeFetchRequest:fetchRequest error:&fetchError];
//  NSArray *results =
//  if (!fetchError) {
//    self.rooms = results;
//    [self.tableView reloadData];
//  }
//
  
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.rooms) {
    return self.rooms.count;
    
  } else {
    
  
    // Return the number of rows in the section.
    return 0;
  }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ROOM_CELL" forIndexPath:indexPath];
  
  Room *room = self.rooms[indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"Room number: %@, Number of Beds: %@, Rating: %@", room.number, room.beds, room.rate];
    // Configure the cell...
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"SHOW_RESERV"]) {
    
    SetReservationVC *destinationVC = segue.destinationViewController;
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    Room *room = self.rooms[indexPath.row];
    destinationVC.selectedRoom = room;
  }
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
