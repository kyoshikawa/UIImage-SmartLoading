//
//  EWAppDelegate.h
//  single-view
//
//  Created by kyoshikawa on 1/11/13.
//  Copyright (c) 2013 Electricwoods LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EWViewController;

@interface EWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) EWViewController *viewController;

@end
