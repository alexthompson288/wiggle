//
//  WGVideo.h
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import <Parse/Parse.h>

@interface WGCategory : NSObject

@property (nonatomic, readonly, strong) NSString *title;
@property (nonatomic, readonly, strong) NSNumber *orderNumber;
@property (nonatomic, readonly, strong) NSMutableArray *objects;

- (id)initWithTitle:(NSString *)title andOrderNumber:(NSNumber *)orderNumber;
- (void)sort;
@end

@interface WGVideo : PFObject <PFSubclassing>

@property (nonatomic) BOOL isDownloading;
@property (nonatomic) BOOL watched;
@property (nonatomic, strong) NSString *offlineURL;
@property (nonatomic, strong) NSString *episodeId;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSNumber *categoryOrderNumber;


// Parse data
@property (strong) NSString *title;
@property (strong) NSString *overview;
@property (strong) NSString *transcript;
@property (strong) NSNumber *orderNumber;
@property (strong) NSString *thumbnailURL;
@property (strong) NSString *videoURL;

- (NSDictionary *)getAttributes;
- (void)download;
- (void)deleteDownload;
- (void)videoWasWatched;
- (NSArray *)relatedVideos;

+ (NSString *)parseClassName;
+ (instancetype)videoWithAttributes:(NSDictionary *) attributes;

+ (void)bootstrap;
+ (void)fetchFromServer:(PFBooleanResultBlock)block;
+ (WGVideo *)getVideoById:(NSString *)objectId;
+ (NSArray *)allVideos;
+ (NSArray *)allCategories;
@end

extern NSString * const WGVideosLoadedNotification;
extern NSString * const WGVideoDownloadDidStartNotification;
extern NSString * const WGVideoDownloadDidProgressNotification;
extern NSString * const WGVideoDownloadDidFinishNotification;
extern NSString * const WGVideoDownloadDidFailNotification;
extern NSString * const WGVideoDownloadDidCancelNotification;
extern NSString * const WGVideoWasWatchedNotification;