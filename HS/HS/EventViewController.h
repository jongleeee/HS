//
//  EventViewController.h
//  HS
//
//  Created by Irene Lee on 7/20/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    int selectedIndex;
}

@property NSMutableArray *eventItems;
@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;

@end
