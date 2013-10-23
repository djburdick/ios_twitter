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

- (NSString *)createdAtPretty {
    NSDate *convertedDate = [self convertStringToDate:self.createdAt];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy, hh:mm a"];

    return [dateFormatter stringFromDate:convertedDate];
}

- (NSURL *)profileImageURL {
    return [NSURL URLWithString:[self.userData valueOrNilForKeyPath:@"profile_image_url"]];
}

- (NSDictionary *)userData {
    return [self.data valueOrNilForKeyPath:@"user"];
}

- (NSString *)tweetId
{
    return [self.data valueOrNilForKeyPath:@"id"];
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

- (NSDate *)convertStringToDate:(NSString *)origDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    return [df dateFromString:origDate];
}

- (NSString *)timeAgo {
    NSDate *convertedDate = [self convertStringToDate:self.createdAt];

    NSDate *todayDate = [NSDate date];
    double ti = [convertedDate timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1) {
    	return @"never";
    } else if (ti < 60) {
    	int diff = round(ti);
    	return [NSString stringWithFormat:@"%ds", diff];
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

