//
//  UpdateNewsViewController.m
//  HS
//
//  Created by Irene Lee on 7/17/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "UpdateNewsViewController.h"
#import "News.h"
#import <Parse/Parse.h>

@interface UpdateNewsViewController ()


@end

@implementation UpdateNewsViewController


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}



- (IBAction)updatePressed:(id)sender {
    
    if (self.textField == nil)
    {
        UIAlertView *aletView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please fill out the news!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    }
    
    PFObject *newsFeed = [PFObject objectWithClassName:@"newsFeed"];
    newsFeed[@"news"] = self.textField;
    [newsFeed saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
    }];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)cancelPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
