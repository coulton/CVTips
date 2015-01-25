//
//  CVTipsController.m
//  Countdown
//
//  Created by Coulton Vento on 12/29/14.
//  Copyright (c) 2014 Coulton Vento. All rights reserved.
//

#import "CVTipsController.h"
#import "CVTipView.h"
#import "CVTipCache.h"

static const CGFloat kCVTipBoxHorizontalPadding = 20;
static const CGFloat kCVTipBoxVerticalPadding = 10;
static const CGFloat kCVTipBoxSnapDamping = 0.4;
static const CGFloat kCVTipBoxVelocityMagnitudeThreshold = 100;
static const CGFloat kCVTipBoxAngularResistance = 2;
static const CGFloat kCVTipBoxGravity = 4;

typedef void (^CVTipsAnimatedOut)();

@interface CVTipsController ()
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIAttachmentBehavior *attachmentBehavior;

@property (nonatomic, assign) CGRect originalBounds;
@property (nonatomic, assign) CGPoint originalCenter;
@property (nonatomic, strong) NSArray *tips;
@property (nonatomic, strong) NSMutableArray *boxes;

@property (nonatomic, strong) UIVisualEffectView *backgroundView;
@property (readonly) UIWindow *window;
@end

@implementation CVTipsController

- (id)initWithTips:(NSArray *)tips
{
    self = [super init];
    if (self) {
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.backgroundView = [[UIVisualEffectView alloc] initWithEffect:effect];
        self.backgroundView.alpha = 0.0;
        self.backgroundView.frame = [[UIScreen mainScreen] bounds];
        [self.window addSubview:self.backgroundView];
        
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.window];
        self.tips = [[NSArray alloc] initWithArray:tips];
        self.boxes = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark -

- (void)show
{
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat boxWidth = screen.size.width - (kCVTipBoxHorizontalPadding * 2);
    
    CGFloat totalHeight = (self.tips.count - 1) * kCVTipBoxVerticalPadding; // padding
    for (CVTip *tip in self.tips) totalHeight += [CVTipView calculateBoxHeightWithTip:tip andBoxWidth:boxWidth];
    CGFloat y = (self.window.frame.size.height - totalHeight)/2;
    
    for (CVTip *tip in self.tips) {
        
        CVTipView *box = [[CVTipView alloc] initWithTip:tip andWidth:boxWidth];
        box.tintColor = self.tintColor;
        [self.window addSubview:box];
        
        // Place offscreen
        CGRect f = box.frame;
        f.origin.x = kCVTipBoxHorizontalPadding;
        f.origin.y = - box.frame.size.height;
        box.frame = f;
        
        // Snap into place
        CGPoint point = CGPointMake(CGRectGetMidX(self.window.frame), y + (box.frame.size.height/2));
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:box snapToPoint:point];
        snap.damping = kCVTipBoxSnapDamping;
        [self.animator addBehavior:snap];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(attachmentGesture:)];
        [box addGestureRecognizer:pan];
        
        y += box.frame.size.height + kCVTipBoxVerticalPadding;
        [self.boxes addObject:box];
    }
    
    [[CVTipCache sharedCache] displayedTips:self.tips];
    
    [UIView animateWithDuration:0.3 delay:0.0
         usingSpringWithDamping:1.0 initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.backgroundView.alpha = 1.0;
                     }
                     completion:nil];
}

- (void)hide
{
    if ([self.delegate respondsToSelector:@selector(tipsControllerDidHide:)]) {
        [self.delegate tipsControllerDidHide:self];
    }
    
    [self.boxes makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.animator removeAllBehaviors];
    
    [UIView animateWithDuration:0.3 delay:0.0
         usingSpringWithDamping:1.0 initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.backgroundView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         self.backgroundView = nil;
                     }];
    
}

#pragma mark Handle Gestures

- (IBAction)attachmentGesture:(UIPanGestureRecognizer*)gesture
{
    CGPoint locationInSuperview = [gesture locationInView:self.window];
    CGPoint locationInBox = [gesture locationInView:gesture.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            
            self.originalBounds = gesture.view.bounds;
            self.originalCenter = gesture.view.center;
            
            UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:self.boxes];
            [self.animator addBehavior:collision];
            
            if (self.attachmentBehavior)
                [self.animator removeBehavior:self.attachmentBehavior];
            
            // Create attachment behavior
            UIOffset touchOffset = UIOffsetMake(locationInBox.x - CGRectGetMidX(gesture.view.bounds),
                                                locationInBox.y - CGRectGetMidY(gesture.view.bounds));
            self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:gesture.view
                                                                offsetFromCenter:touchOffset
                                                                attachedToAnchor:locationInSuperview];
            
            [self.animator addBehavior:self.attachmentBehavior];
            
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            
            CGPoint boxVelocity = [gesture velocityInView:gesture.view];
            CGFloat boxVelocityMagnitude = sqrtf((boxVelocity.x * boxVelocity.x) + (boxVelocity.y * boxVelocity.y));
            
            if (boxVelocityMagnitude > kCVTipBoxVelocityMagnitudeThreshold) {
                
                [self.animator removeAllBehaviors];
                
                // Animate all boxes out
                UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[gesture.view]];
                itemBehavior.action = [self animted];
                itemBehavior.angularResistance = kCVTipBoxAngularResistance;
                [itemBehavior addLinearVelocity:boxVelocity forItem:gesture.view];
                [self.animator addBehavior:itemBehavior];
                
                for (UIView *box in self.boxes) {
                    
                    // Don't add gravity to the box dragged off screen
                    if ([box isEqual:gesture.view])
                        continue;
                    
                    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[ box ]];
                    gravityBehavior.magnitude = kCVTipBoxGravity;
                    gravityBehavior.action = [self animted];
                    [self.animator addBehavior:gravityBehavior];
                }
                
            } else {
                
                // Reset
                [self.animator removeBehavior:self.attachmentBehavior];
            }
            
            break;
        }
            
        default:
            
            // Drag view
            self.attachmentBehavior.anchorPoint =  [gesture locationInView:self.window];
            break;
    }
}

- (CVTipsAnimatedOut)animted
{
    return ^{
        BOOL offscreen = ^{
            for (UIView *box in self.boxes) {
                BOOL onscreen = CGRectIntersectsRect(self.view.bounds, box.frame);
                if (onscreen) return NO;
            }
            return YES;
        }();
        
        // Views aren't visible anymore
        if (offscreen) [self hide];
    };
}

#pragma mark - Getters

- (UIWindow *)window
{
    return [UIApplication sharedApplication].keyWindow;
}

@end
