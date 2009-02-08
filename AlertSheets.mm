#import "AlertSheets.h"


@interface AlertSheetsObj : NSObject
{
  int returnCode;
}
- (void)sheetDidEnd:(NSWindow *)sheet
         returnCode:(int)returnCode
        contextInfo:(void *)contextInfo;
- (int)returnCode;
@end

@implementation AlertSheetsObj

- (void)sheetDidEnd:(NSWindow *)sheet
         returnCode:(int)theReturnCode
        contextInfo:(void *)contextInfo
{
  returnCode = theReturnCode;
  [NSApp stopModal];
}

- (int)returnCode
{ return returnCode;  }

@end

int RunSheet(id panel, NSWindow *attachToWin, NSString *title,
             NSString *msg, NSString *defaultButton, NSString *alternateButton,
             NSString *otherButton)
{
  AlertSheetsObj *obj = [[AlertSheetsObj alloc] autorelease];

  [NSApp  beginSheet:panel
      modalForWindow:attachToWin
       modalDelegate:obj
      didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:)
         contextInfo:nil];
  [NSApp runModalForWindow:panel];
  [NSApp endSheet:panel];
  [panel orderOut:nil];

  NSReleaseAlertPanel(panel);

  return [obj returnCode];
}

NSLock *onlyOneAlertSheetAtATimeLock = nil;

int RunAlertSheet(NSWindow *attachToWin, NSString *title, NSString
                  *msg, NSString *defaultButton, NSString *alternateButton, NSString
                  *otherButton)
{
  if(onlyOneAlertSheetAtATimeLock == nil)
    onlyOneAlertSheetAtATimeLock = [[NSLock alloc] init];
  [onlyOneAlertSheetAtATimeLock lock];

  int returnVal = -1;
  if(attachToWin == nil)
    returnVal = NSRunAlertPanel(title, msg, defaultButton,
                                alternateButton, otherButton);
  else
  {
    id panel = NSGetAlertPanel(title, msg, defaultButton,
                               alternateButton, otherButton);
    returnVal = RunSheet(panel, attachToWin, title, msg,
                         defaultButton, alternateButton, otherButton);
  }

  [onlyOneAlertSheetAtATimeLock unlock];
  return returnVal;
}

int RunInformationalAlertSheet(NSWindow *attachToWin, NSString
                               *title, NSString *msg, NSString *defaultButton, NSString
                               *alternateButton, NSString *otherButton)
{
  if(onlyOneAlertSheetAtATimeLock == nil)
    onlyOneAlertSheetAtATimeLock = [[NSLock alloc] init];
  [onlyOneAlertSheetAtATimeLock lock];

  int returnVal = -1;
  if(attachToWin == nil)
    returnVal = NSRunInformationalAlertPanel(title, msg,
                                             defaultButton, alternateButton, otherButton);
  else
  {
    id panel = NSGetInformationalAlertPanel(title, msg,
                                            defaultButton, alternateButton, otherButton);
    returnVal = RunSheet(panel, attachToWin, title, msg,
                         defaultButton, alternateButton, otherButton);
  }

  [onlyOneAlertSheetAtATimeLock unlock];
  return returnVal;
}

int RunCriticalAlertSheet(NSWindow *attachToWin, NSString *title,
                          NSString *msg, NSString *defaultButton, NSString *alternateButton,
                          NSString *otherButton)
{
  if(onlyOneAlertSheetAtATimeLock == nil)
    onlyOneAlertSheetAtATimeLock = [[NSLock alloc] init];
  [onlyOneAlertSheetAtATimeLock lock];

  int returnVal = -1;
  if(attachToWin == nil)
    returnVal = NSRunCriticalAlertPanel(title, msg,
                                        defaultButton, alternateButton, otherButton);
  else
  {
    id panel = NSGetCriticalAlertPanel(title, msg, defaultButton,
                                       alternateButton, otherButton);
    returnVal = RunSheet(panel, attachToWin, title, msg,
                         defaultButton, alternateButton, otherButton);
  }

  [onlyOneAlertSheetAtATimeLock unlock];
  return returnVal;
}

