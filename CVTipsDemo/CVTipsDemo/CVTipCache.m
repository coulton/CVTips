//
//  CVTipCache.m
//  Countdown
//
//  Created by Coulton Vento on 1/25/15.
//  Copyright (c) 2015 Coulton Vento. All rights reserved.
//

#import "CVTipCache.h"

NSString * kCVTipCacheObject = @"CVTipSharedCache";

@implementation CVTipCache

+ (CVTipCache *)sharedCache
{
    static CVTipCache *sharedCache = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [[CVTipCache alloc] init];
    });
    
    return sharedCache;
}

- (void)wipe
{
    [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:kCVTipCacheObject];
}

- (void)displayedTips:(NSArray*)tips
{
    for (CVTip *tip in tips) {
        [self displayedTip:tip];
    }
}

- (void)displayedTip:(CVTip*)tip
{
    if (![tip isKindOfClass:[CVTip class]]) return;
    
    NSMutableArray *displayed = [[self displayedTips] mutableCopy];
    [displayed addObject:tip.title];
    [[NSUserDefaults standardUserDefaults] setObject:displayed forKey:kCVTipCacheObject];
}

- (BOOL)shouldDisplayTips:(NSArray *)tips
{
    for (CVTip *tip in tips) {
        if (![self shouldDisplayTip:tip]) return NO;
    }
    return YES;
}

- (BOOL)shouldDisplayTip:(CVTip *)tip
{
    if (![tip isKindOfClass:[CVTip class]]) return NO;
    return ![[self displayedTips] containsObject:tip.title];
}

#pragma mark Helpers

- (NSArray *)displayedTips
{
    NSArray *displayed = [[NSUserDefaults standardUserDefaults] objectForKey:kCVTipCacheObject];
    if (!displayed) displayed = @[];
    return displayed;
}

@end
