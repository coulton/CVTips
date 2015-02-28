//
//  CVTipView.h
//  Countdown
//
//  Created by Coulton Vento on 12/29/14.
//  Copyright (c) 2014 Coulton Vento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVTip.h"

@interface CVTipView : UIView

/**
 *  Initialize a CVTipsView.
 *
 *  @param tip   The given CVTip object.
 *  @param width Width of the box.
 *
 *  @return A fully-initialized CVTipView.
 */
- (id)initWithTip:(CVTip *)tip andWidth:(CGFloat)width;

/**
 *  Calcualtes the height with a given tip.
 *
 *  @param tip   The CVTip object containing the correct content.
 *  @param width Width of the box.
 *
 *  @return Projected height of the CVTipView.
 */
+ (CGFloat)calculateBoxHeightWithTip:(CVTip *)tip andBoxWidth:(CGFloat)width;

@end
