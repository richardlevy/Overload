//
//  OverloadTests.m
//  OverloadTests
//
//  Created by Richard Levy on 05/11/2012.
//  Copyright (c) 2012 Richard Levy. All rights reserved.
//

#import "CellTests.h"
#import "Cell.h"

@implementation CellTests 

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


// Test that when a cell is created, it has no pieces on it
- (void)testCellEmptyOnCreation {
    Cell *cell = [[Cell alloc] init];
    
    STAssertTrue([cell isEmpty], @"Created cell should be empty");
    
}

// Tests that adding a piece to an empty cell sets its colour and 
- (void)testAddPieceAssignsColour {
    Cell *cell = [[Cell alloc] init];
    
    STAssertTrue([cell isEmpty], @"Created cell should be empty");
    STAssertFalse([cell isColour:(white)], @"Created cell should not be white");
    
    [cell addPieceOfColour:white];

    STAssertFalse([cell isEmpty], @"Created cell should not be empty");
    STAssertTrue([cell isColour:(white)], @"Created cell should be white");
  
}

// Test that when adding a piece to an empty cell, the count becomes 1
// Also tests setting black colour
- (void)testAddPieceIncrementsCount {
    Cell *cell = [[Cell alloc] init];
    
    // Can use dot-notation because it's a property
    STAssertTrue(cell.pieceCount==0, @"Piece count should be 0");
    
    [cell addPieceOfColour:black];
    
    STAssertFalse([cell isColour:(white)], @"Cell is white but should be black");
    STAssertTrue(cell.pieceCount==1, @"Piece count should be 1");
    
}

// Tests the the cell registers a limit and knows when it's over it
-(void) testOverloadLimit {
    Cell *cell = [[Cell alloc] initWithLimit:3];

    [cell addPieceOfColour:black];
    STAssertFalse([cell isOverloaded], @"Cell should not be over the limit");
    [cell addPieceOfColour:black];
    STAssertFalse([cell isOverloaded], @"Cell should not be over the limit");
    [cell addPieceOfColour:black];
    STAssertTrue([cell isOverloaded], @"Cell should be over the limit");
    
}

// Tests that a cell can be reset
-(void)testCellResets {
    Cell *cell = [[Cell alloc] initWithLimit:2];

    // Add black twice
    [cell addPieceOfColour:black];
    STAssertFalse([cell isOverloaded], @"Cell should not be over the limit");
    [cell addPieceOfColour:black];
    STAssertTrue([cell isOverloaded], @"Cell should be over the limit");
    STAssertFalse([cell isEmpty], @"Cell should not be empty");
    
    // Reset the cell
    [cell reset];
    
    STAssertTrue([cell isEmpty], @"Cell should be empty");
}

@end
