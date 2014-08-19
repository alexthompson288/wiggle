//
//  WGVideo.h
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import <Parse/Parse.h>

@interface WGVideo : PFObject <PFSubclassing>

@property (strong) NSString *title;
@property (strong) NSString *overview;
@property (strong) NSNumber *orderNumber;
@property (strong) NSString *thumbnailURL;
@property (strong) NSString *videoURL;

+ (NSString *)parseClassName;
+ (void)seed:(PFBooleanResultBlock)block;
+ (void)loadAll:(PFBooleanResultBlock)block;
+ (NSArray *)allVideos;
@end
