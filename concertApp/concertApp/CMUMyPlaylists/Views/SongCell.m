//
//  SongCell.m
//  concertApp
//
//  Created by Connor Clancy on 9/22/18.
//  Copyright © 2018 Connor Clancy. All rights reserved.
//

#import "SongCell.h"
#import "UIImageView+AFNetworking.h"

@implementation SongCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSong:(SpotifySong *)song {
    _song = song;
    self.songLabel.text = song.songTitle;
    self.artistLabel.text = song.songArtist;
    [self.albumImageView setImageWithURL:[NSURL URLWithString:song.songAlbumArt]];
}
@end
