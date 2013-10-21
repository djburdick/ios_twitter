//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)screeName {
    return [@"@" stringByAppendingString:[self.userData valueOrNilForKeyPath:@"screen_name"]];
}

- (NSString *)name {
    return [self.userData valueOrNilForKeyPath:@"name"];
}

- (NSString *)createdAt {
    return [self.data valueOrNilForKeyPath:@"created_at"];
}

- (NSString *)timeAgo {
    return [self dateDiff:self.createdAt];
}

- (UIImage *)profileImage {
    NSURL *profileImageURL = [NSURL URLWithString:[self.userData valueOrNilForKeyPath:@"profile_image_url"]];
    NSData *profileImageData = [NSData dataWithContentsOfURL:profileImageURL];
    return [UIImage imageWithData:profileImageData];
}

// TODO: memoize this?
- (NSDictionary *)userData {
    return [self.data valueOrNilForKeyPath:@"user"];
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

// TODO move this to an NSDate category
-(NSString *)dateDiff:(NSString *)origDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSDate *convertedDate = [df dateFromString:origDate];

    NSDate *todayDate = [NSDate date];
    double ti = [convertedDate timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1) {
    	return @"never";
    } else if (ti < 3600) {
    	int diff = round(ti / 60);
    	return [NSString stringWithFormat:@"%dm", diff];
    } else if (ti < 86400) {
    	int diff = round(ti / 60 / 60);
    	return[NSString stringWithFormat:@"%dh", diff];
    } else if (ti < 2629743) {
    	int diff = round(ti / 60 / 60 / 24);
    	return[NSString stringWithFormat:@"%dd", diff];
    } else {
    	return @"never";
    }
}

@end

