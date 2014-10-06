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
@property (nonatomic, readonly, strong) NSMutableArray *objects;

- (id)initWithTitle:(NSString *)title;

@end

@interface WGVideo : PFObject <PFSubclassing>

@property (nonatomic) BOOL isDownloading;
@property (nonatomic) BOOL watched;
@property (nonatomic, strong) NSString *offlineURL;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *categoryName;


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

+ (NSString *)parseClassName;
+ (instancetype)videoWithAttributes:(NSDictionary *) attributes;

+ (void)bootstrap;
+ (void)fetchFromServer:(PFBooleanResultBlock)block;
+ (NSArray *)allVideos;
+ (NSArray *)allCategories;
@end

extern NSString * const WGVideosLoadedNotification;
extern NSString * const WGVideoDownloadDidProgressNotification;
extern NSString * const WGVideoDownloadDidFinishNotification;
extern NSString * const WGVideoDownloadDidFailNotification;
extern NSString * const WGVideoDownloadDidCancelNotification;