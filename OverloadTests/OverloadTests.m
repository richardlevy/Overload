//
//  OverloadTests.m
//  Overload
//
//  Created by Richard Levy on 06/11/2012.
//  Copyright (c) 2012 Richard Levy. All rights reserved.
//
// These are the main game tests

#import "OverloadTests.h"
#import "Overload.h"

@implementation OverloadTests

-(void)testNewGame {
    
    // Turn counter is 0
    // No winner

    Overload* game = [[Overload alloc]init];
    
    STAssertTrue(game.turnCounter==0, @"At start of game, counter should be zero");
    
}

-(void)testOneTurn {
    // Make single play
    // Turn counter is 1
    // No winner
}


@end
