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
#import "SongCell.h"

@interface MyPlaylistsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray<SpotifySong *> *songs;

@end

@implementation MyPlaylistsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Latest Playlist";
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [SpotifyDataManager getPlaylistWithId:@"5TotXALQTIJ5nUQ5YlAFCr" Completion:^(NSDictionary * _Nonnull response) {
        NSArray *temporary = [[NSArray alloc] init];
        temporary = response[@"tracks"][@"items"];
        self.songs = [[SpotifySong songsWithArray:temporary] mutableCopy];
        [self.tableView reloadData];
        NSLog(@"%@", self.songs);
    }];
}


/************************
 
 TABLE VIEW FUNCTIONS
 
 *************************/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongCell"];
    cell.song = self.songs[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songs.count;
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
