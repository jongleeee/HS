//
//  MemberTableViewController.m
//  HS
//
//  Created by Jong Yun Lee on 9/1/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "MemberTableViewController.h"
#import "EditMemberTableViewController.h"

@interface MemberTableViewController ()

@end

@implementation MemberTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.currentUser = [PFUser currentUser];


    self.allFriends = [PFUser query];
    [self.allFriends orderByAscending:@"name"];
    [self.allFriends findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            NSLog(@"%@ %@", error, [error userInfo]);
        }
        else
        {
            self.friendsList = objects;
            [self.tableView reloadData];
        }
    }];
    
    
//    PFQuery *query = [self.friendsRelation query];
//    [query orderByAscending:@"username"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error)
//        {
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//        else
//        {
//            self.friends = objects;
//            [self.tableView reloadData];
//        }
//    }];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showEditFriends"])
    {
        EditMemberTableViewController *viewController = (EditMemberTableViewController *)segue.destinationViewController;
        viewController.friends = [NSMutableArray arrayWithArray:self.friends];
        
    }
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.friendsList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.friendsList objectAtIndex:indexPath.row];
    cell.textLabel.text = user[@"name"];
    
    if ([user.objectId isEqualToString:self.currentUser.objectId])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}



@end
