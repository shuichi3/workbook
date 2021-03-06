//
//  Document.m
//  WayPoints
//
//  Created by 村上 幸雄 on 12/05/06.
//  Copyright (c) 2012年 ビッツ有限会社. All rights reserved.
//

#import "Document.h"

@interface Document ()
@end

@implementation Document

@synthesize version = _version;
@synthesize gpxRoot = _gpxRoot;
@synthesize gpxTrack = _gpxTrack;

- (id)init
{
    DBGMSG(@"%s", __func__);
	if ((self = [super init]) != nil) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        self.version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        NSString    *aVersion = @"1.0";
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"version"]) {
            aVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
        }
        if ([aVersion compare:self.version] != NSOrderedSame) {
            [self clearDefaults];
        }
        
        self.gpxRoot = [GPXRoot rootWithCreator:@"WayPoints Application"];
        self.gpxTrack = [self.gpxRoot newTrack];
        self.gpxTrack.name = @"My Track";
	}
	return self;
}

- (void)dealloc
{
    DBGMSG(@"%s", __func__);
    self.version = nil;
    self.gpxRoot = nil;
    self.gpxTrack = nil;
	//[super dealloc];
}

- (void)clearDefaults
{
    DBGMSG(@"%s", __func__);
    /*
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"item"]) {
        DBGMSG(@"remove item:%@", self.item);
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"item"];
    }
    */
}

- (void)updateDefaults
{
    DBGMSG(@"%s", __func__);
    BOOL    fUpdate = NO;
    
    NSString    *aVersion = @"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"version"]) {
        aVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
        DBGMSG(@"current aVersion:%@", aVersion);
    }
    if (self.version) {
        if ([aVersion compare:self.version] != NSOrderedSame) {
            [[NSUserDefaults standardUserDefaults] setObject:self.version forKey:@"version"];
            fUpdate = YES;
            DBGMSG(@"save version:%@", self.version);
        }
    }
    
    if (fUpdate) {
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)loadDefaults
{
    DBGMSG(@"%s", __func__);
    NSString    *aVersion = @"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"version"]) {
        aVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    }
    if ([aVersion compare:self.version] != NSOrderedSame) {
        [self clearDefaults];
    }
    else {
        /*
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"item"]) {
            self.item = [[NSUserDefaults standardUserDefaults] objectForKey:@"item"];
            DBGMSG(@"read item:%@", self.item);
        }
        */
    }
}

@end
