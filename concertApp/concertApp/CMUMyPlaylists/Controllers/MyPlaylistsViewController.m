//
//  MyPlaylistsViewController.m
//  concertApp
//
//  Created by Connor Clancy on 9/22/18.
//  Copyright © 2018 Connor Clancy. All rights reserved.
//

#import "MyPlaylistsViewController.h"
#import "SpotifyDataManager.h"
#import "SpotifySong.h"

@interface MyPlaylistsViewController ()

@property NSMutableArray<SpotifySong *> *songs;

@end

@implementation MyPlaylistsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Playlists";
    // Do any additional setup after loading the view.
    [SpotifyDataManager getPlaylistWithId:@"5TotXALQTIJ5nUQ5YlAFCr" Completion:^(NSDictionary * _Nonnull response) {
        NSArray *temporary = [[NSArray alloc] init];
        temporary = response[@"tracks"][@"items"];
        self.songs = [[SpotifySong songsWithArray:temporary] mutableCopy];
        NSLog(@"%@", self.songs);
    }];
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
