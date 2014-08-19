//
//  NSString+WGAdditions.m
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import "NSString+WGAdditions.h"

@implementation NSString (WGAdditions)
+ (instancetype)stringWithFileSize:(NSNumber *)bytes
{
    double convertedValue = [bytes doubleValue];
    int multiplyFactor = 0;
    
    NSArray *tokens = @[@"bytes",@"KB",@"MB",@"GB",@"TB"];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, tokens[multiplyFactor]];
}
@end
