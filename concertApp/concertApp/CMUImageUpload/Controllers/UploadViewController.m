//
//  UploadViewController.m
//  concertApp
//
//  Created by Connor Clancy on 9/21/18.
//  Copyright © 2018 Connor Clancy. All rights reserved.
//
@import Firebase;
#import "UploadViewController.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface UploadViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (strong, nonatomic) UIImage *image;
@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Create New Playlist";
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)uploadButtonPressed:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    //TODO: Send Edited image to Rohit Here!
    NSData *imageData = UIImageJPEGRepresentation(editedImage, 1.0);
    // FIREBASE STORAGE
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage reference];
    
    FIRStorageReference *posterRef = [storageRef child:@"images/somePoster.jpg"];
    
    FIRStorageUploadTask *uploadTask = [posterRef putData:imageData
                                                 metadata:nil
                                               completion:^(FIRStorageMetadata *metadata,
                                                            NSError *error) {
                                                   if (error != nil) {
                                                       // Uh-oh, an error occurred!
                                                   } else {
                                                       // Metadata contains file metadata such as size, content-type, and download URL.
                                                       int size = metadata.size;
                                                       // You can also access to download URL after upload.
                                                       [posterRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                                                           if (error != nil) {
                                                               // Uh-oh, an error occurred!
                                                           } else {
                                                               NSURL *downloadURL = URL;
                                                               // Do completion here
                                                               //
                                                           }
                                                       }];
                                                   }
                                               }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
