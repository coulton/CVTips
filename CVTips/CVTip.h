//
//  CVTip.h
//  Countdown
//
//  Created by Coulton Vento on 1/18/15.
//  Copyright (c) 2015 Coulton Vento. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVTip : NSObject

/**
 *  The tip's title.
 */
@property (nonatomic, readonly) NSString *title;

/**
 *  The tip's icon.
 */
@property (nonatomic, readonly) UIImage *icon;

/**
 *  The tip's font.
 */
@property (nonatomic, readonly) UIFont *font;

/**
 *  Helper for determining if the tip has an icon or not.
 */
@property (readonly) BOOL hasIcon;

/**
 *  Initialize a CVTip.
 *
 *  @param title The tip's title.
 *  @param icon  Image to display.
 *  @param font  The font for the tip's title.
 *
 *  @return An initialized CVTip.
 */
- (id)initWithTitle:(NSString *)title icon:(UIImage *)icon font:(UIFont *)font;

@end
