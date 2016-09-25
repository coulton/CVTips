//
//  CVTipsController.h
//  Countdown
//
//  Created by Coulton Vento on 12/29/14.
//  Copyright (c) 2014 Coulton Vento. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CVTipsControllerDelegate;

/**
 *  Controller for presenting tips.
 */
@interface CVTipsController : NSObject

/**
 *  The delegate.
 */
@property (nonatomic, weak) id <CVTipsControllerDelegate> delegate;

/**
 *  Tint color for the presented view.
 */
@property (nonatomic) UIColor *tintColor;

/**
 *  Initialize a tips controller with a given array of tips.
 *
 *  @param tips Array of CVTip objects.
 *
 *  @return A fully-initialized CVTipsController.
 */
- (id)initWithTips:(NSArray *)tips;

/**
 *  Display the tips.
 */
- (void)show;

@end

@protocol CVTipsControllerDelegate <NSObject>

@optional

/**
 *  Called with the tips controller was hidden.
 *
 *  @param tipsController The tips controller.
 */
- (void)tipsControllerDidHide:(CVTipsController *)tipsController;

@end
