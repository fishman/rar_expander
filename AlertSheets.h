#ifndef ALERTSHEETS_H
#define ALERTSHEETS_H

#import <Cocoa/Cocoa.h>

int RunSheet(id panel, NSWindow *attachToWin, NSString *title,
             NSString *msg, NSString *defaultButton, NSString *alternateButton,
             NSString *otherButton);
int RunAlertSheet(NSWindow *attachToWin, NSString *title, NSString
                  *msg, NSString *defaultButton, NSString *alternateButton, NSString
                  *otherButton);
int RunInformationalAlertSheet(NSWindow *attachToWin, NSString *title,
                               NSString *msg, NSString *defaultButton, NSString
                               *alternateButton, NSString *otherButton);
int RunCriticalAlertSheet(NSWindow *attachToWin, NSString *title,
                          NSString *msg, NSString *defaultButton, NSString *alternateButton,
                          NSString *otherButton);

#endif
