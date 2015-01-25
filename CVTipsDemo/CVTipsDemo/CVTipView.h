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

- (id)initWithTip:(CVTip*)tip
         andWidth:(CGFloat)width;

+ (CGFloat)calculateBoxHeightWithTip:(CVTip*)tip
                         andBoxWidth:(CGFloat)width;

@end
