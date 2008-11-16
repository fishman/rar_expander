//
//  RarExpander.h
//  RAR expander
//
//  Created by Reza Jelveh on 11/16/08.
//  Copyright 2008 Acculogic GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface RarExpander : NSObject {
	IBOutlet NSSecureTextField *aSecureTextField;
}

- (IBAction)about:(id)sender;
- (IBAction)acceptPassword:(id)sender;
- (IBAction)cancelPassword:(id)sender;
- (IBAction)donate:(id)sender;
- (IBAction)open:(id)sender;

@end
