//
//  UpdateEventViewController.m
//  HS
//
//  Created by Irene Lee on 7/21/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UpdateEventViewController.h"

@interface UpdateEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButtonPressed;

@end

@implementation UpdateEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _titleTextField.delegate = self;

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButtonPressed) return;
    if (self.titleTextField && self.contentTextView && self.titleTextField.text.length > 0 && self.contentTextView.text.length > 0) {
        self.eventItem = [[Event alloc] init];
        self.eventItem.title = self.titleTextField.text;
        self.eventItem.content = self.contentTextView;
        self.eventItem.datePicked = self.datePicker;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
}
@end
