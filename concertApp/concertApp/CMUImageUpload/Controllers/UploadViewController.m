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
#import "SpotifyDataManager.h"
#import "SpotifySong.h"
#import "MyPlaylistsViewController.h"



@interface UploadViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (weak, nonatomic) IBOutlet UIImageView *uploadedImageView;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property NSMutableArray<SpotifySong *> *songs;

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
    self.uploadedImageView.image = editedImage;
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

- (IBAction)getPlaylistPressed:(id)sender {
    [SpotifyDataManager getPlaylistWithId:@"5TotXALQTIJ5nUQ5YlAFCr" Completion:^(NSDictionary * _Nonnull response) {
        NSArray *temporary = [[NSArray alloc] init];
        temporary = response[@"tracks"][@"items"];
        self.songs = [[SpotifySong songsWithArray:temporary] mutableCopy];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]
                                                 initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.center=self.view.center;
        [activityView startAnimating];
        [self.view addSubview:activityView];
        
        double delayInSeconds = 10.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSLog(@"Do some work");
            [self performSegueWithIdentifier:@"uploadToPlaylist" sender:nil];
            [activityView stopAnimating];
        });
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    MyPlaylistsViewController *playlistViewController = [segue destinationViewController];
    playlistViewController.songs = self.songs;
}


@end
