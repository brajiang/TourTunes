//
//  NearMeViewController.m
//  concertApp
//
//  Created by Connor Clancy on 9/22/18.
//  Copyright © 2018 Connor Clancy. All rights reserved.
//

#import "NearMeViewController.h"
#import "PosterCell.h"
#import "BackendAPIManager.h"
#import "SpotifyDataManager.h"
#import "SpotifySong.h"

@interface NearMeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) UIView *titleView;
@property NSMutableArray<SpotifySong *> *songs;

@end

@implementation NearMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // table view setup
    self.title = @"Concerts Near Me";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // test fetch playlist
}



/************************
 
 TABLE VIEW FUNCTIONS
 
 *************************/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PosterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PosterCell"];
    if (indexPath.row == 0) {
        cell.posterImageView.image = [UIImage imageNamed:@"ed.png"];
    } else if (indexPath.row == 1) {
        cell.posterImageView.image = [UIImage imageNamed:@"andy"];
    } else if (indexPath.row == 2) {
        cell.posterImageView.image = [UIImage imageNamed:@"jason.png"];
    } else if (indexPath.row == 3) {
        cell.posterImageView.image = [UIImage imageNamed:@"maroon.png"];
    } else {
        cell.posterImageView.image = [UIImage imageNamed:@"ed.png"];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
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
