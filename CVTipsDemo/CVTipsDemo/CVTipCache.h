//
//  CVTipCache.h
//  Countdown
//
//  Created by Coulton Vento on 1/25/15.
//  Copyright (c) 2015 Coulton Vento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CVTip.h"

@interface CVTipCache : NSObject

+ (CVTipCache *)sharedCache;
- (void)wipe;

- (void)displayedTips:(NSArray*)tips;
- (void)displayedTip:(CVTip*)tip;

- (BOOL)shouldDisplayTips:(NSArray *)tips;
- (BOOL)shouldDisplayTip:(CVTip *)tip;

@end
