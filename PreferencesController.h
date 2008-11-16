//
//  PreferencesController.h
//  RAR expander
//
//  Created by Reza Jelveh on 11/16/08.
//  Copyright 2008 Acculogic GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PreferencesController : NSObject {
	IBOutlet NSButton *beepButton;
	IBOutlet NSButton *destinationAskButton;
	IBOutlet NSButton *destinationFixedButton;
	IBOutlet NSButton *destinationSameButton;
}

@end
