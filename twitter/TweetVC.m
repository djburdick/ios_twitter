//
//  TweetVC.m
//  twitter
//
//  Created by DJ Burdick on 10/22/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetVC.h"
#import "UIIMageView+AFNetworking.h"
#import "ComposeVC.h"

@interface TweetVC ()
@property (nonatomic, strong) Tweet *tweet;

@property (nonatomic, weak) IBOutlet UITextView *tweetTextView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *screenNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *profileImage;

- (IBAction)onReply:(id)sender;
- (IBAction)retweet:(id)sender;
- (IBAction)favorite:(id)sender;
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

    self.tweetTextView.text = self.tweet.text;
    self.tweetTextView.editable = NO;
    self.tweetTextView.dataDetectorTypes = UIDataDetectorTypeLink;

    self.nameLabel.text = self.tweet.name;
    self.screenNameLabel.text = self.tweet.screeName;
    self.timeLabel.text = self.tweet.createdAtPretty;
    [self.profileImage setImageWithURL:self.tweet.profileImageURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onReply:(id)sender
{
    ComposeVC *cvc = [[ComposeVC alloc] init];
    cvc.replyTo = self.tweet.screeName;
    [self.navigationController pushViewController:cvc animated:YES];
}

- (void)retweet:(id)sender
{
    [[TwitterClient instance] retweetATweet:self.tweet.tweetId success:^(AFHTTPRequestOperation *operation, id response) {
       // NSLog(@"%@", response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // do nothing
    }];

    UIButton *retweetButton = sender;
    retweetButton.enabled = NO;
}

- (void)favorite:(id)sender
{
    [[TwitterClient instance] favoriteATweet:self.tweet.tweetId success:^(AFHTTPRequestOperation *operation, id response) {
       // NSLog(@"%@", response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // do nothing
    }];

    UIButton *favoriteButton = sender;
    favoriteButton.enabled = NO;
}

@end
