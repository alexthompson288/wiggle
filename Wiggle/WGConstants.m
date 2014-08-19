//
//  WGConstants.m
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import "WGConstants.h"

NSString * const SQStashWasSavedNotification = @"SQStashWasSavedNotification";

NSURL *documentURLFromFilename(NSString *filename)
{
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return  [applicationDocumentsDirectory URLByAppendingPathComponent:filename];
}

