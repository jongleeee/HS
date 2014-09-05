//
//  MemberTableViewController.h
//  HS
//
//  Created by Jong Yun Lee on 9/1/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MemberTableViewController : UITableViewController

@property (nonatomic, strong) PFRelation *friendsRelation;
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) PFQuery *allFriends;
@property (nonatomic, strong) NSArray *friendsList;
@property (nonatomic, strong) PFUser *currentUser;

@end
