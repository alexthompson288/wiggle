//
//  WGVideo.h
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import <Parse/Parse.h>

@interface WGVideo : PFObject <PFSubclassing>

@property (nonatomic) BOOL isDownloading;
@property (nonatomic, strong) NSString *offlineURL;

// Parse data
@property (strong) NSString *title;
@property (strong) NSString *overview;
@property (strong) NSNumber *orderNumber;
@property (strong) NSString *thumbnailURL;
@property (strong) NSString *videoURL;

- (NSDictionary *)getAttributes;
- (void)download;

+ (NSString *)parseClassName;
+ (instancetype)videoWithAttributes:(NSDictionary *) attributes;

+ (void)bootstrap;
+ (void)fetchFromServer:(PFBooleanResultBlock)block;
+ (NSArray *)allVideos;

@end

extern NSString * const WGVideosLoadedNotification;
extern NSString * const WGVideoDownloadDidProgressNotification;
extern NSString * const WGVideoDownloadDidFinishNotification;