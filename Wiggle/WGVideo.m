//
//  WGVideo.m
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import "WGVideo.h"
#import <Parse/PFObject+Subclass.h>
#import <AFNetworking/AFNetworking.h>

NSString * const WGVideosLoadedNotification                 = @"WGVideosLoadedNotification";
NSString * const WGVideoDownloadDidProgressNotification     = @"WGVideoDownloadDidProgressNotification";
NSString * const WGVideoDownloadDidFinishNotification       = @"WGVideoDownloadDidFinishNotification";
NSString * const WGVideoDownloadDidFailNotification         = @"WGVideoDownloadDidFailNotification";

#define kVideoDataPath [kDocumentsDirectory stringByAppendingPathComponent:@"videos.plist"]

@implementation WGVideo
@synthesize isDownloading, offlineURL;
@dynamic title, overview, orderNumber, thumbnailURL, videoURL;

static NSMutableArray *allVideos;

+ (NSString *)parseClassName {
    return @"Video";
}

+ (instancetype)videoWithAttributes:(NSDictionary *) attributes
{
    WGVideo *video = [WGVideo object];
    
    video.objectId     = [attributes objectForKey:@"id"];
    video.title        = [attributes objectForKey:@"title"];
    video.overview     = [attributes objectForKey:@"overview"];
    video.orderNumber  = [attributes objectForKey:@"order_number"];
    
    if ([attributes objectForKey:@"offline_url"]){
        video.offlineURL   = [attributes objectForKey:@"offline_url"];
    }
    
    video.thumbnailURL = [attributes objectForKey:@"thumbnail_url"];
    video.videoURL     = @"http://www.quirksmode.org/html5/videos/big_buck_bunny.mp4";//[attributes objectForKey:@"video_url"];

    return video;
}

- (NSDictionary *)getAttributes
{
    NSMutableDictionary *attribs = [NSMutableDictionary dictionaryWithDictionary:@{
             @"id":             self.objectId,
             @"title":          self.title,
             @"overview":       self.overview,
             @"order_number":   self.orderNumber,
             @"thumbnail_url":  self.thumbnailURL,
             @"video_url":      self.videoURL
             }];
    
    if (self.offlineURL) {
        attribs[@"offline_url"] = self.offlineURL;
    }
    
    return attribs;
}

- (void)download
{
    NSLog(@"Downloading %@", self.videoURL);
    
    NSURL *URL              = [NSURL URLWithString:self.videoURL];
    NSURLRequest *request   = [NSURLRequest requestWithURL:URL];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WGVideoDownloadDidProgressNotification
                                                            object:self
                                                          userInfo:@{
                                                                         @"totalBytesRead":             [NSNumber numberWithLongLong:totalBytesRead],
                                                                         @"totalBytesExpectedToRead":   [NSNumber numberWithLongLong:totalBytesExpectedToRead]
                                                                     }];
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.isDownloading = NO;
        NSData *data            = [[NSData alloc] initWithData:responseObject];
        NSURL *destinationURL   = documentURLFromFilename([NSString stringWithFormat:@"%@.mp4", self.objectId]);
        self.offlineURL         = [destinationURL absoluteString];
        
        [data writeToURL:destinationURL atomically:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:WGVideoDownloadDidFinishNotification object:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.isDownloading = NO;
        
        NSLog(@"file downloading error : %@", [error localizedDescription]);
        [[NSNotificationCenter defaultCenter] postNotificationName:WGVideoDownloadDidFailNotification
                                                            object:self
                                                          userInfo:@{
                                                                     @"error": [error localizedDescription]
                                                                     }];
    }];
    
    self.isDownloading = YES;
    [operation start];

}

+ (void)saveToDisk
{
    NSMutableArray *data = [NSMutableArray new];

    for (WGVideo *video in [self allVideos]){
        [data addObject:[video getAttributes]];
    }
    
    if ([data writeToURL:documentURLFromFilename(@"videos.plist") atomically:YES]){
        NSLog(@"Writing videos to disk OK");
    }
    else {
        NSLog(@"Writing videos to disk FAILED!!");
    }
}

+ (void)bootstrap
{
    [WGVideo registerSubclass];
    allVideos = [NSMutableArray new];
    
    NSLog(@"Loading videos...");
    
    NSArray *cachedVideos = [NSArray arrayWithContentsOfURL:documentURLFromFilename(@"videos.plist")];
    if (!cachedVideos){
        NSLog(@"Couldn't retrieve cached videos");
    }
    else {
        NSLog(@"Retrieved %i cached videos", cachedVideos.count);
        for (NSDictionary *videoAttributes in cachedVideos){
            [allVideos addObject:[WGVideo videoWithAttributes:videoAttributes]];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDownloadDidFinish:) name:WGVideoDownloadDidFinishNotification object:nil];
}

+ (void)videoDownloadDidFinish:(NSNotification *)notification
{
    [self saveToDisk];
}

+ (void)fetchFromServer:(PFBooleanResultBlock)block
{
    NSLog(@"Fetching videos from server...");
    PFQuery *query = [PFQuery queryWithClassName:[WGVideo parseClassName]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
//            allVideos = [NSMutableArray arrayWithArray:objects];
            
            NSLog(@"%i videos retrieved from server", allVideos.count);
            
            
//            [self saveToDisk];
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:WGVideosLoadedNotification object:nil];
            
            if (block) block(YES, nil);
        }
        else {
            if (block) block(NO, error);
            NSLog(@"error fetching videos: %@ %@", error, [error userInfo]);
        }
    }];
}



+ (NSArray *)allVideos
{
    return allVideos;
}

@end
