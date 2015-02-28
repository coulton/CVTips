# CVTips

CVTips are presentable tips that overlay the screen's content - great for onboarding. The tips animate in and collide when the user drags the tips around. 

## Installation

If you use [cocoapods](cocoapods.org) (you should), installation is easy.

1. Add CVTips to your Podfile: `pod 'CVTips', '~> 0.1'`
2. Run `pod install`

If you don't use cocoapods, you can always manually import the files in the CVTips directory.

## Basic Implementation

```
// Create tips
CVTip *one = [[CVTip alloc] initWithTitle:@"Dummy tip number one." icon:nil font:[UIFont systemFontOfSize:18]];
CVTip *two = [[CVTip alloc] initWithTitle:@"Dummy tip number two." icon:nil font:[UIFont systemFontOfSize:18]];

// Present them
CVTipsController *tipsController = [[CVTipsController alloc] initWithTips:@[one,two]];
[tipsController show];
```
