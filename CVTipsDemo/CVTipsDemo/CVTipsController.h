//
//  CVTipsController.h
//  Countdown
//
//  Created by Coulton Vento on 12/29/14.
//  Copyright (c) 2014 Coulton Vento. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CVTipsControllerDelegate;

@interface CVTipsController : UIViewController

@property (nonatomic, weak) id <CVTipsControllerDelegate> delegate;
@property (nonatomic, assign) UIColor *tintColor;

- (id)initWithTips:(NSArray*)tips;
- (void)show;

@end

@protocol CVTipsControllerDelegate <NSObject>

@optional
- (void)tipsControllerDidHide:(CVTipsController*)tipsController;

@end
