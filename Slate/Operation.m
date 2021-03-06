//
//  Operation.m
//  Slate
//
//  Created by Jigish Patel on 5/18/11.
//  Copyright 2011 Jigish Patel. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see http://www.gnu.org/licenses

#import "Operation.h"
#import "MoveOperation.h"
#import "ResizeOperation.h"
#import "ChainOperation.h"
#import "LayoutOperation.h"
#import "FocusOperation.h"
#import "SnapshotOperation.h"
#import "ActivateSnapshotOperation.h"
#import "DeleteSnapshotOperation.h"
#import "HintOperation.h"
#import "StringTokenizer.h"
#import "Constants.h"
#import "SlateLogger.h"
#import "SwitchOperation.h"

@implementation Operation

- (id)init {
  self = [super init];
  if (self) {
  }

  return self;
}


- (BOOL)doOperation {
  return YES;
}

- (BOOL)doOperationWithAccessibilityWrapper:(AccessibilityWrapper *)aw screenWrapper:(ScreenWrapper *)sw {
  return YES;
}

- (BOOL)testOperation {
  return YES;
}

+ (id)operationFromString:(NSString *)opString {
  NSMutableArray *tokens = [[NSMutableArray alloc] initWithCapacity:10];
  [StringTokenizer tokenize:opString into:tokens maxTokens:2];
  NSString *op = [tokens objectAtIndex:0];
  Operation *operation = nil;
  if ([op isEqualToString:MOVE]) {
    operation = [MoveOperation moveOperationFromString:opString];
  } else if ([op isEqualToString:RESIZE]) {
    operation = [ResizeOperation resizeOperationFromString:opString];
  } else if ([op isEqualToString:PUSH]) {
    operation = [MoveOperation pushOperationFromString:opString];
  } else if ([op isEqualToString:NUDGE]) {
    operation = [MoveOperation nudgeOperationFromString:opString];
  } else if ([op isEqualToString:THROW]) {
    operation = [MoveOperation throwOperationFromString:opString];
  } else if ([op isEqualToString:CORNER]) {
    operation = [MoveOperation cornerOperationFromString:opString];
  } else if ([op isEqualToString:CHAIN]) {
    operation = [ChainOperation chainOperationFromString:opString];
  } else if ([op isEqualToString:LAYOUT]) {
    operation = [LayoutOperation layoutOperationFromString:opString];
  } else if ([op isEqualToString:FOCUS]) {
    operation = [FocusOperation focusOperationFromString:opString];
  } else if ([op isEqualToString:SNAPSHOT]) {
    operation = [SnapshotOperation snapshotOperationFromString:opString];
  } else if ([op isEqualToString:ACTIVATE_SNAPSHOT]) {
    operation = [ActivateSnapshotOperation activateSnapshotOperationFromString:opString];
  } else if ([op isEqualToString:DELETE_SNAPSHOT]) {
    operation = [DeleteSnapshotOperation deleteSnapshotOperationFromString:opString];
  } else if ([op isEqualToString:HINT]) {
    operation = [HintOperation hintOperationFromString:opString];
  } else if ([op isEqualToString:SWITCH]) {
    operation = [SwitchOperation switchOperationFromString:opString];
  } else {
    SlateLogger(@"ERROR: Unrecognized operation '%@'", opString);
    @throw([NSException exceptionWithName:@"Unrecognized Operation" reason:[NSString stringWithFormat:@"Unrecognized operation '%@' in '%@'", op, opString] userInfo:nil]);
  }
  return operation;
}

@end
