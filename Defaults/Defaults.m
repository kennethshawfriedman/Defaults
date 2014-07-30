//
//  Defaults.m
//  Defaults
//
//  Created by Kenny Friedman on 7/23/14.
//  Copyright (c) 2014 Kenneth Friedman. All rights reserved.
//

#import "Defaults.h"

@implementation Defaults

- (void)mainViewDidLoad {
	[self setUpMail];
	[self setUpBrowser];
}

- (void) setUpMail {
	[_popUpMail removeAllItems];
	[_popUpMail addItemsWithTitles:@[@"Mail", @"Gmail (Web View)"]];
	
	if ([[self getCurrentMailDefault] isEqualToString:@"com.apple.mail"]) {
		[_popUpMail selectItemAtIndex:0];
	} else {
		[_popUpMail selectItemAtIndex:1];
	}
}

#pragma Mail Section

- (NSString *) getCurrentMailDefault {
	NSString *filePath = [NSString stringWithFormat: @"/Users/%@/Library/Preferences/com.apple.LaunchServices.plist",NSUserName()];
	NSDictionary *pList = [[NSDictionary alloc] initWithContentsOfFile:filePath];;
	NSArray *arrayOfProperties = [pList objectForKey:@"LSHandlers"];
	
	for (int i=0; i<arrayOfProperties.count; i++) {
		NSDictionary *tempA = [arrayOfProperties objectAtIndex:i];
		
		if ([[tempA objectForKey:@"LSHandlerURLScheme"] isEqualToString:@"mailto"]) {
			return [tempA objectForKey:@"LSHandlerRoleAll"];
		}
	}
	return @"No default set";
}

- (void) setCurrentMailDefault: (NSString *) address {
	NSString *filePath = [NSString stringWithFormat: @"/Users/%@/Library/Preferences/com.apple.LaunchServices.plist",NSUserName()];
	NSMutableDictionary *pList = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];;
	NSMutableArray *arrayOfProperties = [pList objectForKey:@"LSHandlers"];
	for (int i=0; i<arrayOfProperties.count; i++) {
		NSMutableDictionary *tempA = [arrayOfProperties objectAtIndex:i];
		
		if ([[tempA objectForKey:@"LSHandlerURLScheme"] isEqualToString:@"mailto"]) {
			//NSLog(@"%@", [tempA objectForKey:@"LSHandlerRoleAll"]);
			[tempA setObject:address forKey:@"LSHandlerRoleAll"];
		}
	}
	NSLog(@"%@", pList);
	[pList writeToFile:filePath atomically:YES];
	LSSetDefaultHandlerForURLScheme((__bridge CFStringRef)@"mailto",(__bridge CFStringRef)address);
	[self readPList];
}

- (void) readPList {
	//this is needed to refresh defaults that have been cached
	NSTask *task = [[NSTask alloc] init];
	NSString *fileP = [NSString stringWithFormat: @"/Users/%@/Library/Preferences/com.apple.LaunchServices",NSUserName()];
	[task setArguments:@[[NSString stringWithFormat:@"defaults read %@", fileP]]];
	[task launch];
}

- (IBAction)changeMail:(NSPopUpButton *)sender {
	switch ([_popUpMail indexOfSelectedItem]) {
		case 0:
			[self setCurrentMailDefault:@"com.apple.mail"];
			break;
		case 1:
			[self setCurrentMailDefault:@"com.google.chrome"];
			break;
		default:
			break;
	}
}

#pragma Browser Section

- (void) setUpBrowser {
	[_popUpBrowser removeAllItems];
	[_popUpBrowser addItemsWithTitles:@[@"Safari", @"Chrome"]];
	
	if ([[self getCurrentBrowserDefault] isEqualToString:@"com.apple.safari"]) {
		[_popUpBrowser selectItemAtIndex:0];
	} else {
		[_popUpBrowser selectItemAtIndex:1];
	}
}

- (NSString *) getCurrentBrowserDefault {
	NSString *filePath = [NSString stringWithFormat: @"/Users/%@/Library/Preferences/com.apple.LaunchServices.plist",NSUserName()];
	NSDictionary *pList = [[NSDictionary alloc] initWithContentsOfFile:filePath];;
	NSArray *arrayOfProperties = [pList objectForKey:@"LSHandlers"];
	
	for (int i=0; i<arrayOfProperties.count; i++) {
		NSDictionary *tempA = [arrayOfProperties objectAtIndex:i];
		
		if ([[tempA objectForKey:@"LSHandlerURLScheme"] isEqualToString:@"http"]) {
			return [tempA objectForKey:@"LSHandlerRoleAll"];
		}
	}
	return @"No default set";
}

- (void) setCurrentBrowserDefault: (NSString *) address {
	LSSetDefaultHandlerForURLScheme((__bridge CFStringRef)@"http",(__bridge CFStringRef)address);
	[self readPList];
}

- (IBAction)changeBrowser:(NSPopUpButton *)sender {
	switch ([_popUpBrowser indexOfSelectedItem]) {
		case 0:
			[self setCurrentBrowserDefault:@"com.apple.safari"];
			break;
		case 1:
			[self setCurrentBrowserDefault:@"com.google.chrome"];
			break;
		default:
			break;
	}
}




@end
