//
//  NewsFeedTableViewController.m
//  HS
//
//  Created by Irene Lee on 7/17/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "News.h"
#import "NewsFeedTableViewController.h"
#import "UpdateNewsViewController.h"
#import <Parse/Parse.h>

@interface NewsFeedTableViewController ()
@end

@implementation NewsFeedTableViewController





- (void)viewDidLoad
{
    [super viewDidLoad];

    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser)
    {
        NSLog(@"Current User: %@", currentUser[@"username"]);
    }
    else
    {
        [self performSegueWithIdentifier:@"loginView" sender:self];
    
    }

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loginView"])
    {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.newsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsPrototype";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    News *item = [self.newsList objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.text;
    
    return cell;
}


@end
