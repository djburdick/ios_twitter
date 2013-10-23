//
//  ComposeVC.m
//  twitter
//
//  Created by DJ Burdick on 10/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "ComposeVC.h"
#import "UIIMageView+AFNetworking.h"

static NSString *DefaultTweetText = @"What's Happening";

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

    self.tweetTextView.delegate = self;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(postTweet)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTweet)];

    [self.tweetTextView setText:DefaultTweetText];

    User *userData = [User currentUser];

    self.screenName.text = [NSString stringWithFormat:@"%@%@", @"@", [userData.data objectForKey:@"screen_name"]];

    self.name.text = [userData.data objectForKey:@"name"];
    [self.profileImage setImageWithURL:[NSURL URLWithString:[userData.data objectForKey:@"profile_image_url"]]];

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

- (void)textViewDidBeginEditing:(UITextView *)textView
{

    if ([self.tweetTextView.text isEqualToString:DefaultTweetText])
        self.tweetTextView.text = nil;
}

@end
