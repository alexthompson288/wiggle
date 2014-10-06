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
NSString * const WGVideoDownloadDidCancelNotification       = @"WGVideoDownloadDidCancelNotification";

#define kVideoDataPath [kDocumentsDirectory stringByAppendingPathComponent:@"videos.plist"]

@interface WGCategory()

- (void)addVideo:(WGVideo *)video;

@end

@interface WGVideo()

@property (nonatomic, strong) AFHTTPRequestOperation *downloadOperation;

- (void)populateCategories;

@end

@implementation WGVideo

@synthesize isDownloading, offlineURL, downloadOperation;
@dynamic title, overview, orderNumber, thumbnailURL, videoURL, transcript;

static NSMutableArray *allVideos;
static NSMutableArray *allCategories;

+ (NSString *)parseClassName {
    return @"Video";
}

+ (instancetype)videoWithAttributes:(NSDictionary *) attributes
{
    WGVideo *video = [WGVideo object];
    
    video.objectId     = [attributes objectForKey:@"id"];
    video.title        = [attributes objectForKey:@"title"];
    video.overview     = [attributes objectForKey:@"overview"];
    video.transcript   = [attributes objectForKey:@"transcript"];
    video.orderNumber  = [attributes objectForKey:@"order_number"];
    video.offlineURL   = [attributes objectForKey:@"offline_url"];
    video.thumbnailURL = [attributes objectForKey:@"thumbnail_url"];
    video.videoURL     = [attributes objectForKey:@"video_url"]; // @"http://localhost:8000/video.mp4"; //@"http://www.quirksmode.org/html5/videos/big_buck_bunny.mp4";
    video.categoryName = [attributes objectForKey:@"category_name"];
    video.categoryId   = [attributes objectForKey:@"category_id"];
    return video;
}

- (NSDictionary *)getAttributes
{
    NSMutableDictionary *attribs = [NSMutableDictionary dictionaryWithDictionary:@{
             @"id":             self.objectId,
             @"title":          self.title,
             @"overview":       self.overview,
             @"order_number":   self.orderNumber,
             @"transcript":     self.transcript,
             @"thumbnail_url":  self.thumbnailURL,
             @"video_url":      self.videoURL,
             @"category_id":    self.categoryId,
             @"category_name":  self.categoryName
             }];
    
    for (id key in attribs) {
        if (![attribs objectForKey:key]){
            [attribs removeObjectForKey:key];
        }
    }

    
    return attribs;
}

- (void)deleteDownload
{
    
    if (self.isDownloading && self.downloadOperation) {
        NSLog(@"Cancelling in progress download");
        [self.downloadOperation cancel];
        self.isDownloading     = NO;
        self.downloadOperation = nil;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:WGVideoDownloadDidCancelNotification object:self];
    }
    else if (self.offlineURL) {
        NSLog(@"Deleting download file");
        
        [[NSFileManager defaultManager] removeItemAtURL:[NSURL URLWithString:self.offlineURL] error:nil];
        self.offlineURL = nil;

        [[NSNotificationCenter defaultCenter] postNotificationName:WGVideoDownloadDidCancelNotification object:self];
    }
}

- (void)download
{
    NSLog(@"Downloading %@", self.videoURL);
    
    NSURL *URL               = [NSURL URLWithString:self.videoURL];
    NSURLRequest *request    = [NSURLRequest requestWithURL:URL];
    self.downloadOperation   = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    __weak WGVideo* weakSelf = self;

    
    [self.downloadOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WGVideoDownloadDidProgressNotification
                                                            object:weakSelf
                                                          userInfo:@{
                                                                         @"totalBytesRead":             [NSNumber numberWithLongLong:totalBytesRead],
                                                                         @"totalBytesExpectedToRead":   [NSNumber numberWithLongLong:totalBytesExpectedToRead]
                                                                     }];
    }];
    

    
    [self.downloadOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.isDownloading      = NO;
        weakSelf.downloadOperation  = nil;
        
        NSData *data            = [[NSData alloc] initWithData:responseObject];
        NSURL *destinationURL   = documentURLFromFilename([NSString stringWithFormat:@"%@.mp4", weakSelf.objectId]);
        weakSelf.offlineURL     = [destinationURL absoluteString];
        
        [data writeToURL:destinationURL atomically:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:WGVideoDownloadDidFinishNotification object:weakSelf];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.isDownloading      = NO;
        weakSelf.downloadOperation  = nil;
        
        NSLog(@"file downloading error : %@", [error localizedDescription]);
        [[NSNotificationCenter defaultCenter] postNotificationName:WGVideoDownloadDidFailNotification
                                                            object:weakSelf
                                                          userInfo:@{
                                                                     @"error": [error localizedDescription]
                                                                     }];
    }];
    
    self.isDownloading = YES;
    [downloadOperation start];

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
    return;
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
    [self populateCategories];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveToDisk) name:WGVideoDownloadDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveToDisk) name:WGVideoDownloadDidCancelNotification object:nil];
}


+ (void)fetchFromServer:(PFBooleanResultBlock)block
{
//    return;
    NSLog(@"Fetching videos from server...");
    PFQuery *query = [PFQuery queryWithClassName:[WGVideo parseClassName]];
    [query includeKey:@"category"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            allVideos = [NSMutableArray arrayWithArray:objects];
            
            for (WGVideo *video in allVideos){
                PFObject *category = video[@"category"];
                video.categoryId   = category.objectId;
                video.categoryName = category[@"name"];
            }
            
            [self populateCategories];
            NSLog(@"%i videos retrieved from server", allVideos.count);
            
            
            [self saveToDisk];
            [[NSNotificationCenter defaultCenter] postNotificationName:WGVideosLoadedNotification object:nil];
            
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

+ (NSArray *)allCategories
{
    return allCategories;
}

+ (void)populateCategories {
    NSMutableDictionary *categories = [NSMutableDictionary new];
    
    for (WGVideo *video in [self allVideos]){
        WGCategory *category = categories[video.categoryId];
        if (!category){
            category = [[WGCategory alloc] initWithTitle:video.categoryName];
            categories[video.categoryId] = category;
        }
        [category addVideo:video];
    }
    NSLog(@"allCategories %i", [allVideos count]);
    allCategories = [NSMutableArray arrayWithArray:[categories allValues]];
}

@end



@implementation WGCategory

- (id)initWithTitle:(NSString *)title {
    self = [super init];
    if (self){
        _title      = title;
        _objects    = [NSMutableArray new];
    }
    return self;
}

- (void)addVideo:(WGVideo *)video {
    [_objects addObject:video];
}

@end
