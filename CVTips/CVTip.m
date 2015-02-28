//
//  CVTip.m
//  Countdown
//
//  Created by Coulton Vento on 1/18/15.
//  Copyright (c) 2015 Coulton Vento. All rights reserved.
//

#import "CVTip.h"

const CGFloat kCVTipDefaultFontSize = 15;

@interface CVTip ()

@property (nonatomic) NSString *title;
@property (nonatomic) UIImage *icon;
@property (nonatomic) UIFont *font;

@end

@implementation CVTip

- (id)initWithTitle:(NSString*)title icon:(UIImage*)icon font:(UIFont*)font
{
    self = [super init];
    if (self) {
        
        self.title = title;
        self.icon = icon;
        self.font = font ? font : [UIFont systemFontOfSize:kCVTipDefaultFontSize];
        
    }
    return self;
}

#pragma mark - Getters

- (BOOL)hasIcon
{
    return self.icon && self.icon.size.width > 0 && self.icon.size.height > 0;
}

@end
