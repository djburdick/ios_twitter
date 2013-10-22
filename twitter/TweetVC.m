//
//  TweetVC.m
//  twitter
//
//  Created by DJ Burdick on 10/22/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetVC.h"

@interface TweetVC ()
@property (nonatomic, strong) TweetCell *cell;

@property (nonatomic, weak) IBOutlet UILabel *tweetLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *screenNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *profileImage;
@end

@implementation TweetVC

- (id)initWithTweetCell:(TweetCell *)cell
{
    self = [super init];
    
    if (self) {
        self.title = @"Tweet";
        self.cell = cell;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tweetLabel.text = self.cell.tweetLabel.text;
    self.nameLabel.text = self.cell.nameLabel.text;
    self.screenNameLabel.text = self.cell.screenNameLabel.text;
    self.timeLabel.text = self.cell.timeLabel.text;
    self.profileImage.image = self.cell.profileImage.image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
