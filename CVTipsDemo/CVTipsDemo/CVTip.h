//
//  CVTip.h
//  Countdown
//
//  Created by Coulton Vento on 1/18/15.
//  Copyright (c) 2015 Coulton Vento. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVTip : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, assign) UIFont *font;
@property (readonly) BOOL hasIcon;

- (id)initWithTitle:(NSString*)title
               icon:(UIImage*)icon
               font:(UIFont*)font;

@end
