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

static NSArray *allVideos;

+ (NSString *)parseClassName {
    return @"Video";
}



+ (instancetype)videoWithAttributes:(NSDictionary *) attributes {
    WGVideo *video = [WGVideo object];

    video.title        = [attributes objectForKey:@"title"];
    video.overview     = [attributes objectForKey:@"overview"];
    video.orderNumber  = [attributes objectForKey:@"order_number"];
    video.thumbnailURL = [attributes objectForKey:@"thumbnail_url"];
    video.videoURL     = [attributes objectForKey:@"video_url"];

    return video;
}

+ (void)seed:(PFBooleanResultBlock)block {
    NSArray *data = @[@{
                          @"title":@"Pip and Jazz the juggler",
                          @"overview":@"The circus is in town, so Pip and Pop head off to watch Jazz the juggler perform his tricks.  Pop joins in the act and they end up with another letter!",
                          @"order_number":[NSNumber numberWithInt:250],
                          @"created_at":@"2014-04-07T15:09:44.870Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/j_jazz_the_juggler.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/j_jazz_the_juggler.jpg"
                          },
                      @{
                          @"title":@"Pip and Roxy the fox",
                          @"overview":@"Pip and Pop are looking for that rather special letter that makes the sound 'x' in 'box'.  They decide they might have some luck in a place where people exercise so they go to the gym of Roxy the fox.",
                          @"order_number":[NSNumber numberWithInt:270],
                          @"created_at":@"2014-05-13T10:41:38.339Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/x_roxy_the_fox.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/x_roxy_the_fox.jpg"
                          },
                      @{
                          @"title":@"Pip and Yaz the yo-yo",
                          @"overview":@"Pip and Pop are looking for the letter that makes the sound 'y' for 'yes'.  But they have to go to do their show and tell at school first.  Pip decides to talk about his yo-yo called Yaz.",
                          @"order_number":[NSNumber numberWithInt:280],
                          @"created_at":@"2014-05-13T10:44:24.361Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/y_yaz_the_yoyo.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/y_yaz_the_yoyo.jpg"
                          },
                      @{
                          @"title":@"Pip and Vinnie the vet",
                          @"overview":@"Pip and Pop are looking for the letter that makes the sound 'v' in 'voice'.  On the trip Pop manages to hurt himself and has to visit Vinnie the vet.  Maybe Pop will get better and they will find the letter!",
                          @"order_number":[NSNumber numberWithInt:250],
                          @"created_at":@"2014-05-13T10:39:32.690Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/v_vinnie_the_vet.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/v_vinnie_the_vet.jpg"
                          },
                      @{
                          @"title":@"Pip and Sammi the singer",
                          @"overview":@"Sammi is singing tonight in the theatre. Could Pip and Pop find the 's' there?",
                          @"order_number":[NSNumber numberWithInt:10],
                          @"created_at":@"2014-04-23T16:14:23.644Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/s_sammi_the_singer.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/s_sammi_the_singer.jpg"
                          },
                      @{
                          @"title":@"Pip and Ali the acrobat",
                          @"overview":@"Pip and Pip go and see their acrobatic friend Ali.  Has he seen the 'a'?",
                          @"order_number":[NSNumber numberWithInt:20],
                          @"created_at":@"2014-04-23T16:14:53.272Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/a_ali_the_acrobat.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/a_ali_the_acrobat.jpg"
                          },
                      @{
                          @"title":@"Pip and Terry the troll",
                          @"overview":@"Pip and Pop have to find the letter that makes the sound 't' in 'tree'.  They have heard Terry the troll might have it!",
                          @"order_number":[NSNumber numberWithInt:30],
                          @"created_at":@"2014-04-23T16:15:26.092Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/t_terry_the_troll.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/t_terry_the_troll.jpg"
                          },
                      @{
                          @"title":@"Pip and Umberto the Umbrella",
                          @"overview":@"Pip and Pop are looking for the letter that makes the sound 'u' in 'up'.  But on their trip the weather gets bad and it begins to rain.  They need an umbrella.  Could this umbrella help them find the letter they are looking for?",
                          @"order_number":[NSNumber numberWithInt:150],
                          @"created_at":@"2014-05-13T10:37:27.369Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/u_umberto_the_umbrella.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/u_umberto_the_umbrella.jpg"
                          },
                      @{
                          @"title":@"Pip and Paddy the postman",
                          @"overview":@"Pip and Pop are looking for the letter that makes the sound 'p' for 'pony'.  They meet a friendly postman called Paddy.  Can he help Pip and Pop with their mission?",
                          @"order_number":[NSNumber numberWithInt:40],
                          @"created_at":@"2014-05-13T10:30:46.488Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/p_paddy_the_postman.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/p_paddy_the_postman.jpg"
                          },
                      @{
                          @"title":@"Pip and Carla the crab",
                          @"overview":@"Pip and Pop go underwater in search of the letter that makes the sound 'c' in 'club'.  They might be in luck as they come across Carla and her cave.",
                          @"order_number":[NSNumber numberWithInt:110],
                          @"created_at":@"2014-05-02T07:42:31.961Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/c_carla_the_crab.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/c_carla_the_crab.jpg"
                          },
                      @{
                          @"title":@"Pip and Lulu the librarian",
                          @"overview":@"Lulu the librarian explains to Pip and Pop how the letters got scattered all over Timble Tomble.  Maybe she can help find a letter as well...",
                          @"order_number":[NSNumber numberWithInt:205],
                          @"created_at":@"2014-04-23T16:17:51.395Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/l_lulu_the_librarian.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/l_lulu_the_librarian.jpg"
                          },
                      @{
                          @"title":@"Pip and Kelly the kangaroo",
                          @"overview":@"Pip and Pop are looking for the letter that makes the sound 'k' for 'king'.  On their way they meet Kelly and Kiki.  Can these kangaroos help Pip and Pop?",
                          @"order_number":[NSNumber numberWithInt:120],
                          @"created_at":@"2014-05-13T10:28:28.030Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/k_kelly_the_kangaroo.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/k_kelly_the_kangaroo.jpg"
                          },
                      @{
                          @"title":@"Pip and Harry the horse",
                          @"overview":@"Pip and Pop pay Harry the horse a visit looking for the 'h'...",
                          @"order_number":[NSNumber numberWithInt:170],
                          @"created_at":@"2014-04-23T16:16:38.556Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/h_harry_the_horse.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/h_harry_the_horse.jpg"
                          },
                      @{
                          @"title":@"Pip and Mo the mountain climber",
                          @"overview":@"Pip and Pop have heard the 'm' is at the top of the mountain.  They need Mo to help...",
                          @"order_number":[NSNumber numberWithInt:70],
                          @"created_at":@"2014-04-23T16:24:37.526Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/m_mo_the_mountain_climber.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/m_mo_the_mountain_climber.jpg"
                          },
                      @{
                          @"title":@"Pip and Nora the Nanna",
                          @"overview":@"Pip and Pop get cold on their hunt for the letter that makes the sound 'n' for 'nose' and drop into Nora the Nanna's house for a nice cup of tea. @",
                          @"order_number":[NSNumber numberWithInt:60],
                          @"created_at":@"2014-04-07T15:03:42.830Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/n_nora_the_nanna.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/n_nora_the_nanna.jpg"
                          },
                      @{
                          @"title":@"Pip and quiet queen",
                          @"overview":@"Pip and Pop are looking for a rather special sound.  It is the 'qu' you hear in 'quick'.  They to visit the quiet queen.  Shhhhh.  If they don't make too much noise, maybe the quiet queen will help them!",
                          @"order_number":[NSNumber numberWithInt:310],
                          @"created_at":@"2014-05-13T10:34:18.547Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/qu_quiet_queen.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/qu_quiet_queen.jpg"
                          },
                      @{
                          @"title":@"Pip and Ravi the rapper",
                          @"overview":@"Ravi rhymes.  He rocks.  He raps.  Can he help Pip and Pop find the 'r'?",
                          @"order_number":[NSNumber numberWithInt:160],
                          @"created_at":@"2014-04-15T12:01:53.632Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/r_ravi_the_rapper.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/r_ravi_the_rapper.jpg"
                          },
                      @{
                          @"title":@"Pip and Elsa the elephant",
                          @"overview":@"Pip and Pop are looking for the letter that makes the sound 'e' for 'elf'.  They go to the zoo and meet Elsa the elephant.  Does she have what they are looking for?",
                          @"order_number":[NSNumber numberWithInt:140],
                          @"created_at":@"2014-05-13T10:26:22.451Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/e_elsa_the_elephant.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/e_elsa_the_elephant.jpg"
                          },
                      @{
                          @"title":@"Pip and Bob the balloon",
                          @"overview":@"Pip and Pop are looking for the letter that makes the sound 'b' for 'Ben'.  They come across Bob the balloon, who needs their help...",
                          @"order_number":[NSNumber numberWithInt:180],
                          @"created_at":@"2014-05-13T10:24:31.153Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/b_bob_the_balloon.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/b_bob_the_balloon.jpg"
                          },
                      @{
                          @"title":@"Pip and Fifi the florist",
                          @"overview":@"Pip and Pop look for the letter that makes the sound 'f' for 'flower'.  Can Fifi help them?",
                          @"order_number":[NSNumber numberWithInt:190],
                          @"created_at":@"2014-04-23T16:17:08.197Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/f_fifi_the_florist.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/f_fifi_the_florist.jpg"
                          },
                      @{
                          @"title":@"Pip and Gav the goal keeper",
                          @"overview":@"Gav is a great goalkeeper. Maybe he can help Pip and Pop find the 'g' among his goalposts...",
                          @"order_number":[NSNumber numberWithInt:90],
                          @"created_at":@"2014-04-23T16:13:57.263Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/g_gav_the_goalkeeper.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/g_gav_the_goalkeeper.jpg"
                          },
                      @{
                          @"title":@"Pip and Winnie the wishing well",
                          @"overview":@"Pip and Pop wish they could give the letter 'w' back to Benny.  Perhaps Winnie can help them...",
                          @"order_number":[NSNumber numberWithInt:260],
                          @"created_at":@"2014-04-15T13:06:06.966Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/w_winnie_the_wishing_well.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/w_winnie_the_wishing_well.jpg"
                          },
                      @{
                          @"title":@"Pip and Diego the dancer",
                          @"overview":@"Pop gives Pip a great idea where he might find the letter that makes the sound 'd' for 'dancer'.  They head off to Diego the dancer's dancing studio.",
                          @"order_number":[NSNumber numberWithInt:80],
                          @"created_at":@"2014-04-07T15:06:57.806Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/d_diego_the_dancer.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/d_diego_the_dancer.jpg"
                          },
                      @{
                          @"title":@"Pip and Zippy the zip",
                          @"overview":@"Pop gets a bit wet when it starts raining.  Pip unzips Zippy the zip to let Pop go into his pocket!",
                          @"order_number":[NSNumber numberWithInt:292],
                          @"created_at":@"2014-04-23T16:28:51.769Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/z_zippy_the_zip.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/z_zippy_the_zip.jpg"
                          },
                      @{
                          @"title":@"Pip and Olive the ostrich",
                          @"overview":@"Pip and Pop go to the desert in search of the letter that makes the sound 'o'.  They better not disturb Olive the ostrich or her eggs!",
                          @"order_number":[NSNumber numberWithInt:100],
                          @"created_at":@"2014-04-15T12:03:42.287Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/o_olive_the_ostrich.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/o_olive_the_ostrich.jpg"
                          },
                      @{
                          @"title":@"Pip and Izzy the inspector",
                          @"overview":@"Pip and Pop are looking for the letter that makes the sound 'i' for 'insect' when they run into Izzy the inspector.  Izzy is herself looking for something...she is looking for the silly trolls!",
                          @"order_number":[NSNumber numberWithInt:50],
                          @"created_at":@"2014-04-07T15:05:27.332Z",
                          @"thumbnail_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/i_izzy_the_inspector.mp4",
                          @"video_url":@"https://s3-eu-west-1.amazonaws.com/pipisodes/i_izzy_the_inspector.jpg"
                          }];
    
    NSMutableArray *videos = [NSMutableArray new];
    
    for (NSDictionary *attributes in data) {
        [videos addObject:[WGVideo videoWithAttributes:attributes]];
    }
    
    [WGVideo saveAllInBackground:videos block:block];
}

+ (void)loadAll:(PFBooleanResultBlock)block {

    PFQuery *query = [PFQuery queryWithClassName:[WGVideo parseClassName]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            allVideos = objects;
            block(YES, nil);
        } else {
            block(NO, error);
            NSLog(@"error fetching videos: %@ %@", error, [error userInfo]);
        }
    }];
}

+ (NSArray *)allVideos {
    if (!allVideos) {
        allVideos = [NSArray new];
    }
    return allVideos;
}

@end
