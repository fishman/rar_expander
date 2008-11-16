//
//  RarExpander.m
//  RAR expander
//
//  Created by Reza Jelveh on 11/16/08.
//  Copyright 2008 Acculogic GmbH. All rights reserved.
//

#import "RarExpander.h"

#define HANDLE void*;
#import "dll.hpp"

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


@implementation RarExpander

- (void)donate:(id)sender
{
  [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.paypal.com"]];
}

- (void)open:(id)sender
{
  struct RAROpenArchiveData testArchive;
  struct RARHeaderData header;
  HANDLE archive;
  int result;

  testArchive.OpenMode    = RAR_OM_EXTRACT;
  testArchive.ArcName     = "/Users/timebomb/Desktop/sample/test_archive_1.rar";
  testArchive.CmtBuf      = NULL;
  testArchive.CmtBufSize  = 0;

  header.CmtBuf = NULL;

  archive = RAROpenArchive(&testArchive);

  fprintf(stderr, "OpenResult = %i\n", testArchive.OpenResult);

  RARSetChangeVolProc(archive, volumeChange);
  RARSetProcessDataProc(archive, processData);

  RARReadHeader(archive, &header);

  fprintf(stderr, "Filename = %s\n", header.FileName);

  result = RARProcessFile(archive, RAR_EXTRACT, "/Users/timebomb/Desktop/sample", NULL);

  fprintf(stderr, "\nresult = %i\n", result);

  RARCloseArchive(archive);

}

@end
