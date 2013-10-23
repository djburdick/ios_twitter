//
//  ComposeVC.m
//  twitter
//
//  Created by DJ Burdick on 10/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "ComposeVC.h"
#import "UIIMageView+AFNetworking.h"

@interface ComposeVC ()
@property (nonatomic, weak) IBOutlet UITextView *tweetTextView;
@property (nonatomic, weak) IBOutlet UILabel *screenName;
@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UIImageView *profileImage;
@end

@implementation ComposeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(postTweet)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTweet)];

    User *userData = [User currentUser];
    _screenName.text = [userData.data objectForKey:@"screen_name"];
    _name.text = [userData.data objectForKey:@"name"];
    [_profileImage setImageWithURL:[NSURL URLWithString:[userData.data objectForKey:@"profile_image_url"]]];

    if (self.replyTo) {
        self.tweetTextView.text = self.replyTo;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)postTweet
{
    [[TwitterClient instance] postTweetForCurrentUser:self.tweetTextView.text success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // do nothing
    }];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelTweet
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
