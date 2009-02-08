//
//  RarExpander.m
//  RAR expander
//
//  Created by Reza Jelveh on 11/16/08.
//  Copyright 2008 Acculogic GmbH. All rights reserved.
//

#import "RarExpander.h"
#import "Debug.h"

#import "dll.hpp"

#define STOP_PROCESSING -1
#define CONTINUE_PROCESSING 1
#define SUCCESS 0

int volumeChange(char * nextArchiveName, int mode) {
  if(mode = RAR_VOL_ASK) {
    fprintf(stderr, "Volume not found %s\n", nextArchiveName);
    return 0;
  } else {
    fprintf(stderr, "Next volume is %s\n", nextArchiveName);
    return 1;
  }
}



int processData(unsigned char * block, int size) {
  fprintf(stderr, ".");
  return 1;
}

int needPassword(RarExpander *rarExpander, char *passwordBuffer, int bufferSize){
  NSString *password;

  [rarExpander showPasswordSheet];
  password = [rarExpander password];
  strcpy(passwordBuffer, [password cString]);
  bufferSize = [password length];
  return CONTINUE_PROCESSING;
}

int processRarCallbackMessage(UINT msg, LONG UserData, LONG P1, LONG P2) {
  id rarExpander = (RarExpander*)UserData;
	switch (msg) {
		// case UCM_CHANGEVOLUME : return volumeSwitch(current_env, current_obj, (char *) P1, (int) P2);
		// case UCM_PROCESSDATA :	return processData(current_env, current_obj, (unsigned char *) P1, (int) P2);
		// case UCM_NEEDPASSWORD :	return needPassword(current_env, current_obj, (char *) P1, (int) P2);
    case UCM_CHANGEVOLUME :
      fprintf(stderr, "Change volume");
      return STOP_PROCESSING;
    case UCM_PROCESSDATA :
      fprintf(stderr, "process data");
      return STOP_PROCESSING;
    case UCM_NEEDPASSWORD :
      return needPassword(rarExpander, (char *) P1, (int) P2);
		default :
		  fprintf(stderr, "Unknown message passed to RAR callback function.");
		  return STOP_PROCESSING;
	}
}

bool extractAllFiles(HANDLE archive, char * destinationPath) {
	struct RARHeaderData fileHeader;
	int result;

	fileHeader.CmtBuf = NULL;

	while((result = RARReadHeader(archive, &fileHeader)) == SUCCESS) {
		fprintf(stderr, "Extracing file %s\n", fileHeader.FileName);

		result = RARProcessFile(archive, RAR_EXTRACT, destinationPath, NULL);

		if (result != SUCCESS) {
			fprintf(stderr, "Error processing file\n");
			return false;
		}
	}

	if (result != ERAR_END_ARCHIVE) {
		fprintf(stderr, "Error in archive\n");
		return false;
	}

	return true;
}
@implementation RarExpander


- (void)donate:(id)sender
{
  [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.paypal.com"]];
}

- (void)extractArchive:(NSString*)fileName
{
  struct RAROpenArchiveData testArchive;
  struct RARHeaderData header;
  HANDLE archive;
  int result;

  testArchive.OpenMode    = RAR_OM_EXTRACT;
  testArchive.ArcName     = (char*)[fileName cString];
  testArchive.CmtBuf      = NULL;
  testArchive.CmtBufSize  = 0;

  header.CmtBuf = NULL;

  archive = RAROpenArchive(&testArchive);

	RARSetCallback(archive, processRarCallbackMessage, (LONG) self);
  // RARSetChangeVolProc(archive, volumeChange);
  // RARSetProcessDataProc(archive, processData);

  result = extractAllFiles(archive, "/Users/timebomb/Desktop/sample");

  RARCloseArchive(archive);
}

- (NSString*)password
{
  return [password stringValue];
}

- (void)sheetDidEnd:(NSWindow *)sheet
         returnCode:(int)returnCode
        contextInfo:(void *)contextInfo
{
  [NSApp stopModal];
}

- (void)showPasswordSheet
{
  [NSApp  beginSheet:passwordSheet
      modalForWindow:progressWindow
       modalDelegate:self
      didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:)
         contextInfo:nil];
  [NSApp runModalForWindow:progressWindow];
  [NSApp endSheet:passwordSheet];
  [passwordSheet orderOut:nil];
}

- (void)endPassSheet:(id)sender
{
  // Return to normal event handling
  [NSApp endSheet:passwordSheet];

  // Hide the sheet
  [passwordSheet orderOut:sender];
}

- (void)cancelPassSheet:(id)sender
{
  [self endPassSheet];
}

- (void)openPanelDidEnd:(NSOpenPanel *)openPanel
             returnCode:(int)returnCode
            contextInfo:(void *)x
{
  if (returnCode == NSOKButton) {
    NSString *path = [openPanel filename];
    DLog(@"%@", path);

		[openPanel orderOut:self];
    [self extractArchive:path];
  }
}

- (IBAction)showOpenPanel:(id)sender
{
  NSOpenPanel *panel = [NSOpenPanel openPanel];

  [panel beginSheetForDirectory:nil
                           file:nil
                          types:[NSArray arrayWithObjects:@"rar",nil]
                 modalForWindow:progressWindow
                  modalDelegate:self
                 didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)
                    contextInfo:NULL];
}

- (void)about:(id)sender
{

}


@end
