//
//  UpdateNewsViewController.h
//  HS
//
//  Created by Irene Lee on 7/17/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface UpdateNewsViewController  : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textField;
- (IBAction)updatePressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;


@end
