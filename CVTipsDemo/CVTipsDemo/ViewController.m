//
//  ViewController.m
//  CVTipsDemo
//
//  Created by Coulton Vento on 1/25/15.
//  Copyright (c) 2015 Coulton Vento. All rights reserved.
//

#import "ViewController.h"
#import "CVTipsController.h"
#import "CVTip.h"

@interface ViewController () <CVTipsControllerDelegate>
@property (nonatomic, strong) CVTipsController *tipsController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(displayTips) withObject:nil afterDelay:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - CVTips

- (void)displayTips
{
    CVTip *one = [[CVTip alloc] initWithTitle:@"Dummy tip number one."
                                         icon:nil
                                         font:[UIFont systemFontOfSize:18]];
    
    CVTip *two = [[CVTip alloc] initWithTitle:@"Dummy tip number two."
                                         icon:nil
                                         font:[UIFont systemFontOfSize:18]];
    
    self.tipsController = [[CVTipsController alloc] initWithTips:@[one,two]];
    self.tipsController.delegate = self;
    [self.tipsController show];
}

- (void)tipsControllerDidHide:(CVTipsController *)tipsController
{
    self.tipsController = nil;
    NSLog(@"Hidden!");
}

@end
