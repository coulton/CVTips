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

/**
 *  @return Shared cache.
 */
+ (CVTipCache *)sharedCache;

/**
 *  Wipe the cache.
 */
- (void)wipe;

/**
 *  Updates the tip cache with some tips.
 *  Upon adding the tip to the cache, `shouldDisplayTip:` will return NO.
 *
 *  @param tips The tips displayed.
 */
- (void)displayedTips:(NSArray *)tips;

/**
 *  Updates the tip cache with a given tip.
 *
 *  @param tip The tip displayed.
 */
- (void)displayedTip:(CVTip *)tip;

/**
 *  Whether or not you should display certain tips.
 *
 *  @param tips Array of tips wishing to be presented.
 *
 *  @return BOOL indicating if the tips have been presented before.
 */
- (BOOL)shouldDisplayTips:(NSArray *)tips;

/**
 *  Whether or not you should display a given tip.
 *
 *  @param tip The tip wishing to be presented.
 *
 *  @return BOOL indicating if the tip has been presented before.
 */
- (BOOL)shouldDisplayTip:(CVTip *)tip;

@end
