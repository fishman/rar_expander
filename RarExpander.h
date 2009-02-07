//  RAR expander
//
//  Created by Reza Jelveh on 11/16/08.
//  Copyright 2008 Acculogic GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface RarExpander : NSObject {
	IBOutlet NSSecureTextField *aSecureTextField;
  IBOutlet NSWindow *passWindow;
  IBOutlet NSWindow *progressWindow;

}

- (IBAction)about:(id)sender;
- (IBAction)acceptPassword:(id)sender;
- (IBAction)cancelPassword:(id)sender;
- (IBAction)donate:(id)sender;
- (IBAction)open:(id)sender;


- (void)openPanelDidEnd:(NSOpenPanel *)openPanel
             returnCode:(int)returnCode
            contextInfo:(void *)x;
- (IBAction)showOpenPanel:(id)sender;

@end
