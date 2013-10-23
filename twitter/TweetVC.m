//
//  TweetVC.m
//  twitter
//
//  Created by DJ Burdick on 10/22/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetVC.h"
#import "UIIMageView+AFNetworking.h"

@interface TweetVC ()
@property (nonatomic, strong) Tweet *tweet;

@property (nonatomic, weak) IBOutlet UILabel *tweetLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *screenNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *profileImage;
@end

@implementation TweetVC

- (id)initWithTweet:(Tweet *)tweet
{
    self = [super init];
    
    if (self) {
        self.title = @"Tweet";
        self.tweet = tweet;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tweetLabel.text = self.tweet.text;
    self.nameLabel.text = self.tweet.name;
    self.screenNameLabel.text = self.tweet.screeName;
    self.timeLabel.text = self.tweet.createdAt;
    [self.profileImage setImageWithURL:self.tweet.profileImageURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
