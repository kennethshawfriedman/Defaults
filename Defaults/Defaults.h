//
//  Defaults.h
//  Defaults
//
//  Created by Kenny Friedman on 7/23/14.
//  Copyright (c) 2014 Kenneth Friedman. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>

@interface Defaults : NSPreferencePane {
	
	//NSView *_mainView;
}

- (void)mainViewDidLoad;

@property (strong) IBOutlet NSPopUpButton *popUpMail;
@property (strong) IBOutlet NSPopUpButton *popUpBrowser;
@property (strong) IBOutlet NSTextField *tempLabelForTesting;
@property (strong) IBOutlet NSPopUpButton *popUpMusic;

- (IBAction)changeMail:(NSPopUpButton *)sender;
- (IBAction)changeBrowser:(NSPopUpButton *)sender;
- (IBAction)changeMusic:(NSPopUpButton *)sender;


@end
