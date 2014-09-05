//
//  UpdateEventViewController.h
//  HS
//
//  Created by Irene Lee on 7/21/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface UpdateEventViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property Event *eventItem;

@end
