//
//  UIImage+SmartLoading.h
//
//  Created by Kaz Yoshikawa on 10/10/25.
//  Copyright 2010 Electricwoods LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

//
//	UIImage (SmartLoading)
//

//	DESCRIPTION:
//
//	This category code loads bast possible images for the device.  For example, you can provide multiple images
//	for iPhone/iPad, and retina/non-retina, portrait/landscape, plus iPhone5 wide screen/classic screen.
//
//	Modifier combination:
//
//		<Basename> | "-Landscape" | "-568h"    | "@2x" (retina)  | "~iphone" | <extension>
//				   | "-Portrait"               | "" (non-retina) | "~ipad"   |
//				   | "" (Unknown)              |                 | ""        |
//
//		(Images for Landscape)
//		"Base-Landscape-h568@2x~iphone.png"		<-- iPhone5
//		"Base-Landscape@2x~iphone.png"			<-- iPhone4/4S
//		"Base-Landscape~iphone.png"				<-- iPhone3GS
//		"Base-Landscape@2x~ipad.png"				<-- iPad3
//		"Base-Landscape~ipad.png"				<-- iPad1/2
//		"Base-Landscape@2x.png"					<-- iPhone4/4S/5, iPad3
//		"Base-Landscape.png"						<-- iPhone3GS/4/4S/5, iPad1/2/3
//
//		(Images for Portrait)
//		"Base-Portrait@2x~iphone.png"			<-- iPhone4/4S/5
//		"Base-Portrait~iphone.png"				<-- iPhone3GS
//		"Base-Portrait@2x~ipad.png"				<-- iPad3
//		"Base-Portrait~ipad.png"					<-- iPad2
//		"Base-Portrait@2x.png"					<-- iPhone4/4S/5, iPad3
//		"Base-Portrait.png"						<-- iPhone3GS/4/4S/5, iPad1/2/3
//
//		(Whatever Orientation )
//		"Base@2x~iphone.png"						<-- iPhone4/4S/5
//		"Base~iphone.png"						<-- iPhone3GS
//		"Base@2x~ipad.png"						<-- iPad3
//		"Base~ipad.png"							<-- iPad2/3
//		"Base@2x.png"							<-- iPhone4/4S/5, iPad3
//		"Base.png"								<-- iPhone3GS/4/4S/5, iPad1/2/3


@interface UIImage (SmartLoading)

// Load images baset for the orientation

+ (NSData *)imageDataWithContentsOfFile_:(NSString *)file interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
+ (UIImage *)imageWithContentsOfFile_:(NSString *)file interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
+ (NSData *)imageDataWithContentsOfURL_:(NSURL *)imageURL interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
+ (UIImage *)imageWithContentsOfURL_:(NSURL *)imageURL interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
+ (UIImage *)imageNamed_:(NSString *)name interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

// Load images for whatever orientation

+ (NSData *)imageDataWithContentsOfFile_:(NSString *)file;
+ (UIImage *)imageWithContentsOfFile_:(NSString *)file;
+ (NSData *)imageDataWithContentsOfURL_:(NSURL *)imageURL;
+ (UIImage *)imageWithContentsOfURL_:(NSURL *)imageURL;
+ (UIImage *)imageNamed_:(NSString *)name;

@end
