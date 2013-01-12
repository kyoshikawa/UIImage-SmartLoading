//
//  EWViewController.m
//  single-view
//
//  Created by kyoshikawa on 1/11/13.
//  Copyright (c) 2013 Electricwoods LLC. All rights reserved.
//

#import "EWViewController.h"
#import "UIImage+SmartLoading.h"


@interface EWViewController ()

@end

@implementation EWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self updateImage:self.interfaceOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self updateImage:toInterfaceOrientation];
}

- (void)updateImage:(UIInterfaceOrientation)interfaceOrientation
{
	UIImage *image = [UIImage imageNamed_:@"Bookshelf" interfaceOrientation:self.interfaceOrientation];
	self.imageView.image = image;
}


@end
