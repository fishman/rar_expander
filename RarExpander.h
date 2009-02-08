//  RAR expander
//
//  Created by Reza Jelveh on 11/16/08.
//  Copyright 2008 Acculogic GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface RarExpander : NSObject {
	IBOutlet NSSecureTextField *password;
  IBOutlet NSWindow *progressWindow;
  IBOutlet NSWindow *passwordSheet;
}

- (IBAction)about:(id)sender;
- (IBAction)endPassSheet:(id)sender;
- (IBAction)cancelPassSheet:(id)sender;
- (IBAction)donate:(id)sender;
- (IBAction)showOpenPanel:(id)sender;

- (NSString*)password;

- (void)extractArchive:(NSString*)fileName;
- (void)openPanelDidEnd:(NSOpenPanel *)openPanel
             returnCode:(int)returnCode
            contextInfo:(void *)x;

@end
