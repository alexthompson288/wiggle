//
//  WGVideo.m
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import "WGVideo.h"
#import <Parse/PFObject+Subclass.h>

@implementation WGVideo

@dynamic title, overview, orderNumber, thumbnailURL, videoURL;

static NSMutableArray *allVideos;

+ (NSString *)parseClassName {
    return @"Video";
}

+ (instancetype)videoWithAttributes:(NSDictionary *) attributes
{
    WGVideo *video = [WGVideo object];

    video.title        = [attributes objectForKey:@"title"];
    video.overview     = [attributes objectForKey:@"overview"];
    video.orderNumber  = [attributes objectForKey:@"order_number"];
    video.thumbnailURL = [attributes objectForKey:@"thumbnail_url"];
    video.videoURL     = [attributes objectForKey:@"video_url"];

    return video;
}

+ (void)loadAll:(PFBooleanResultBlock)block
{
    PFQuery *query = [PFQuery queryWithClassName:[WGVideo parseClassName]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            allVideos = [NSMutableArray arrayWithArray:objects];
            block(YES, nil);
        } else {
            block(NO, error);
            NSLog(@"error fetching videos: %@ %@", error, [error userInfo]);
        }
    }];
}

+ (NSArray *)allVideos
{
    if (!allVideos) {
        allVideos = [NSMutableArray new];
    }
    return allVideos;
}

@end
