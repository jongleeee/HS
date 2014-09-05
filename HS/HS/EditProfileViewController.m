//
//  EditProfileViewController.m
//  HS
//
//  Created by Irene Lee on 7/23/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "EditProfileViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.currentUser = [PFUser currentUser];
    self.currentPicture.userInteractionEnabled = YES;
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    
    self.currentUsername.text = self.currentUser[@"name"];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;

}






- (IBAction)donePressed:(id)sender {
    
    
    NSString *parse_usernameField = [self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *parse_passwordField = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *parse_passwordConfirmField = [self.passwordConfirmField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
   
    NSString *parse_phoneField = [self.phoneField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if (parse_usernameField.length == 0 && parse_phoneField.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"missing informaiton" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        return;
        
    }
    else if (parse_usernameField.length != 0 && parse_phoneField.length == 0)
    {
        self.currentUser[@"name"] = parse_usernameField;
    }
    else if (parse_usernameField.length == 0 && parse_phoneField.length == 0)
    {
        self.currentUser[@"phone"] = parse_phoneField;
    }
    else
    {
        self.currentUser[@"name"] = parse_usernameField;
        self.currentUser[@"phone"] = parse_phoneField;
        
        
    }
    
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@, %@", error, [error userInfo]);
        }
    }];

    
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (IBAction)changePasswordPressed:(id)sender {
    
    [PFUser requestPasswordResetForEmailInBackground:self.currentUser[@"email"]];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Request Sent!" message:@"please check your email" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
    
}

- (IBAction)imagePressed:(id)sender {
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose from Album", nil];

    [action showInView:self.view];
    

}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d", buttonIndex);
    NSLog(@"%@", [actionSheet title]);
    if (buttonIndex == 0)
    {
        [self takePhoto];
        [self uploadImage];
    }
    else if (buttonIndex == 1)
    {
        [self getPhoto];
        [self uploadImage];
    }


}



#pragma mark - Upload Method
- (void)takePhoto
{
   
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    
    [self presentViewController:self.imagePicker animated:NO completion:nil];
    
    
}

- (void)getPhoto
{
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)uploadImage
{
    if (self.image != nil)
    {
        UIImage *newImage = [self resizeImage:self.image toWidth:120.0f andHeight:131.0f];
    }
    
    
    [self viewWillAppear:YES];
}


- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height
{
    CGSize newSize = CGSizeMake(width, height);
    CGRect newRectangle = CGRectMake(0, 0, width, height);
    
    UIGraphicsBeginImageContext(newSize);
    [self.image drawInRect:newRectangle];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
    
}


//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [self dismissViewControllerAnimated:NO completion:nil];
//    
//    [self.tabBarController setSelectedIndex:3];
//}


@end
