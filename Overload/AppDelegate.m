//
//  AppDelegate.m
//  Overload
//
//  Created by Richard Levy on 05/11/2012.
//  Copyright (c) 2012 Richard Levy. All rights reserved.
//

#import "AppDelegate.h"
#import "Overload.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[[Overload alloc]init]playGame];
}

@end
