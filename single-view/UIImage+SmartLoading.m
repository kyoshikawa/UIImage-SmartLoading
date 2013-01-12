//
//  UIImage+SmartLoading.m
//
//  Created by Kaz Yoshikawa on 10/10/25.
//  Copyright 2010 Electricwoods LLC. All rights reserved.
//

#import "UIImage+SmartLoading.h"


//
//	UIImage (SmartLoading)
//

@implementation UIImage (SmartLoading)

static NSArray *image_modifiers(UIInterfaceOrientation interfaceOrientation)
{
	//	EXAMPLES:
	//
	//	iPad3:		"foo@2x~ipad.png", "foo@2x.png", "foo~ipad.png", "foo.png"
	//	iPad2:		"foo~ipad.png", "foo.png"
	//	iPhone4:	"foo@2x~iphone.png","foo@2x.png", "foo~iphone.png" "foo.png"
	//	iPhone3GS:	"foo~iphone.png", "foo.png"

	// <basename><usage_specific_modifiers><scale_modifier><device_modifier>.png


	NSMutableArray *idioms = [NSMutableArray array];
	[idioms addObject:[UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? @"~ipad" : @"~iphone"];
	[idioms addObject:@""];

	NSMutableArray *retinas = [NSMutableArray array];
	if ([UIScreen mainScreen].scale == 2.0) [retinas addObject:@"@2x"];
	[retinas addObject:@""];

	NSMutableArray *dimensions = [NSMutableArray array];
	BOOL iPhone = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
	if (iPhone && [[UIScreen mainScreen] bounds].size.height == 568) [dimensions addObject:@"-568h"];
	[dimensions addObject:@""];

	NSMutableArray *orientations = [NSMutableArray array];
	if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) [orientations addObject:@"-Landscape"];
	if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) [orientations addObject:@"-Portrait"];
	[orientations addObject:@""];

	NSMutableArray *modifiers = [NSMutableArray array];
	for (NSString *orientation in orientations) {
		for (NSString *dimension in dimensions) {
			for (NSString *retina in retinas) {
				for (NSString *idiom in idioms) {
					NSString *modifier = [NSString stringWithFormat:@"%@%@%@%@", orientation, dimension, retina, idiom];
					[modifiers addObject:modifier];
				}
			}
		}
	}
	return modifiers;
}

+ (UIImage *)imageWithContentsOfFile_:(NSString *)file imageData:(NSData **)imageData interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	//	try loading the best possible image for the device
	//
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *extension = [file pathExtension];
	NSMutableArray *extensions = [NSMutableArray array];
	if ([extension length] > 0) [extensions addObject:extension];
	if ([extensions count] == 0) {
		[extensions addObjectsFromArray:@[@"png", @"PNG"]];
	}

	NSString *basename = [file stringByDeletingPathExtension];
	for (NSString *modifier in image_modifiers(interfaceOrientation)) {
		for (NSString *extension in extensions) {
			NSString *path = [[basename stringByAppendingString:modifier] stringByAppendingPathExtension:extension];
			if ([fileManager fileExistsAtPath:path]) {
				NSData *data = [NSData dataWithContentsOfFile:path];
				if (data) {
					NSLog(@"found: %@", [path lastPathComponent]);
					CGFloat scale = [modifier hasPrefix:@"@2x"] ? 2.0f : 1.0f;
					UIImage *image = [UIImage imageWithData:data scale:scale];
					if (image) {
						if (imageData) *imageData = data;
						return image;
					}
				}
			}
		}
	}
	return nil;
}

+ (UIImage *)imageWithContentsOfURL_:(NSURL *)URL imageData:(NSData **)imageData interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([NSThread mainThread] && ![URL isFileURL]) NSLog(@"Warning: Please consider not using main thread.");

	NSURL *baseURL = [URL URLByDeletingLastPathComponent];
	NSString *lastPathComponent = [URL lastPathComponent];
	NSString *baseFileName = [lastPathComponent stringByDeletingPathExtension];
	NSString *extension = [lastPathComponent pathExtension];
	NSMutableArray *extensions = [NSMutableArray array];
	if ([extension length] > 0) [extensions addObject:extension];
	if ([extensions count] == 0) {
		[extensions addObjectsFromArray:@[@"png", @"PNG"]];
	}
	
	for (NSString *modifier in image_modifiers(interfaceOrientation)) {
		for (NSString *extension in extensions) {
			NSString *filename = [[baseFileName stringByAppendingString:modifier] stringByAppendingPathExtension:extension];
			NSURL *theURL = [baseURL URLByAppendingPathComponent:filename];
			NSData *data = [NSData dataWithContentsOfURL:theURL];
			if (data) {
				CGFloat scale = [modifier hasPrefix:@"@2x"] ? 2.0f : 1.0f;
				UIImage *image = [UIImage imageWithData:data scale:scale];
				if (image) {
					if (imageData) *imageData = data;
					return image;
				}
			}
		}
	}
	return nil;
}

#pragma mark -

+ (NSData *)imageDataWithContentsOfFile_:(NSString *)file interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	NSData *imageData = nil;
	__unused UIImage *image = [self imageWithContentsOfFile_:file imageData:&imageData interfaceOrientation:interfaceOrientation];
	return imageData;
}

+ (UIImage *)imageWithContentsOfFile_:(NSString *)file interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	NSData *imageData = nil;
	UIImage *image = [self imageWithContentsOfFile_:file imageData:&imageData interfaceOrientation:interfaceOrientation];
	return image;
}

+ (NSData *)imageDataWithContentsOfURL_:(NSURL *)imageURL interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	NSData *imageData = nil;
	__unused UIImage *image = [self imageWithContentsOfURL_:imageURL imageData:&imageData interfaceOrientation:interfaceOrientation];
	return imageData;
}

+ (UIImage *)imageWithContentsOfURL_:(NSURL *)imageURL interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	NSData *imageData = nil;
	UIImage *image = [self imageWithContentsOfURL_:imageURL imageData:&imageData interfaceOrientation:interfaceOrientation];
	return image;
}

+ (UIImage *)imageNamed_:(NSString *)name interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
	UIImage *image = [self imageWithContentsOfFile_:path interfaceOrientation:interfaceOrientation];
	return image;
}

#pragma mark -

+ (NSData *)imageDataWithContentsOfFile_:(NSString *)file
{
	NSData *imageData = nil;
	__unused UIImage *image = [self imageWithContentsOfFile_:file imageData:&imageData interfaceOrientation:UIDeviceOrientationUnknown];
	return imageData;
}

+ (UIImage *)imageWithContentsOfFile_:(NSString *)file
{
	NSData *imageData = nil;
	UIImage *image = [self imageWithContentsOfFile_:file imageData:&imageData interfaceOrientation:UIDeviceOrientationUnknown];
	return image;
}

+ (NSData *)imageDataWithContentsOfURL_:(NSURL *)imageURL
{
	NSData *imageData = nil;
	__unused UIImage *image = [self imageWithContentsOfURL_:imageURL imageData:&imageData interfaceOrientation:UIDeviceOrientationUnknown];
	return imageData;
}

+ (UIImage *)imageWithContentsOfURL_:(NSURL *)imageURL
{
	NSData *imageData = nil;
	UIImage *image = [self imageWithContentsOfURL_:imageURL imageData:&imageData interfaceOrientation:UIDeviceOrientationUnknown];
	return image;
}

+ (UIImage *)imageNamed_:(NSString *)name
{
	return [self imageNamed_:name interfaceOrientation:UIDeviceOrientationUnknown];
}


@end
