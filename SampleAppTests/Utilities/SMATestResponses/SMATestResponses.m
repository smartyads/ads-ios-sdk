//
//  SMATestResponses.m
//  SampleApp
//
//  Created by Ievgen on 5/1/17.
//  Copyright © 2017 SmartyAds. All rights reserved.
//

#import "SMATestResponses.h"

@implementation SMATestResponses

+ (NSString *)responseContent {
    return [self linkWithHrefURL:[NSURL URLWithString:@"https://ssp.smartyads.com/img/300_250.png"]];
}

+ (NSString *)responseContentWithLocalPNGResource {
    return [self htmlADMForLocalResource:@"100-dollars" ofType:@"png"];
}

+ (NSString *)responseContentWithLocalJPGResource {
    return [self htmlADMForLocalResource:@"gold-bricks" ofType:@"jpeg"];
}

+ (NSString *)responseContentWithLocalGIFResource {
    return [self htmlADMForLocalResource:@"helping-people" ofType:@"gif"];
}

+ (NSString *)htmlADMForLocalResource:(NSString *)resource ofType:(NSString *)type {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *path = [bundle pathForResource:resource ofType:type];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSError *error = nil;
    [url checkResourceIsReachableAndReturnError:&error];
    
    if (error) {
        NSLog(@"Error: resource %@ is not reachable", error);
    }
    
    return [self linkWithHrefURL:url];
}

+ (NSString *)linkWithHrefURL:(NSURL *)url {
    return [NSString stringWithFormat:@"<a href=\"https://smartyads.com\"><img src=\"%@\"/></a>", [NSString stringWithFormat:@"%@", url]];
}

+ (NSString *)responseWithJSScriptResource {
    return @"";
}

@end
