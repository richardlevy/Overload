//
//  BoardTests.m
//  Overload
//
//  Created by Richard Levy on 05/11/2012.
//  Copyright (c) 2012 Richard Levy. All rights reserved.
//

#import "BoardTests.h"
#import "Board.h"
#import "CoOrdinate.h"

@implementation BoardTests

-(void)testBoardCreatedWithEmptyCells {
    Board *board = [[Board alloc] initWithSize:3];
    STAssertNotNil(board, @"Board should not be nil");
    CoOrdinate *move = [[CoOrdinate alloc]init];
    
    // Can only check if its empty by asking if moves are valid
    // Ironically, there are no valid moves at this time!
    for (int y=0 ; y < 3 ; y++){
        for (int x=0 ; x < 3 ; x++) {
            move.x=x;
            move.y=y;
            STAssertTrue([board isValidMoveAt:move withColour:white],@"Should be able to place white here. x=%d, y=%d", x, y);
            STAssertTrue([board isValidMoveAt:move withColour:black],@"Should be able to place black here. x=%d, y=%d", x, y);
        }
    }
}

-(void)testValidEdgePlays {
    Board *board = [[Board alloc]initWithSize:3];
    
    // Tests for an edge
    CoOrdinate* move = [[CoOrdinate alloc]initWithX:0  Y:0];
    
    [self overloadAt:move onBoard:board withColour:white andLimit:2 forTest:@"testValidEdgePlays"];

}

-(void)testValidSidePlays {
    Board *board = [[Board alloc]initWithSize:3];
    
    // Tests for an edge
    CoOrdinate* move = [[CoOrdinate alloc]initWithX:1 Y:0];
    
    [self overloadAt:move onBoard:board withColour:white andLimit:3 forTest:@"testValidSidePlays"];
}

-(void)testValidMiddlePlays {
    Board *board = [[Board alloc]initWithSize:3];
    
    // Tests for an edge
    CoOrdinate* move = [[CoOrdinate alloc]initWithX:1 Y:1];
    
    [self overloadAt:move onBoard:board withColour:white andLimit:4 forTest:@"testValidMiddlePlays"];
}

-(void)testInvalidPlays {
    Board *board = [[Board alloc]initWithSize:3];
    
    CoOrdinate* move = [[CoOrdinate alloc]initWithX:0 Y:0];
    
    [board placePieceAt:(move) ofColour:(white)];
    
    // Test that we can't put a black piece on
    STAssertFalse([board isValidMoveAt:move withColour:black], @"Piece is already white - should not be able to place black" );
}

// The only way we can do this, because of the design, is to explode a white cell and see if a black cell can be placed on an adjacent square
-(void)testExplodeSingleCellMiddle {
    // Create a clean board
    Board *board = [[Board alloc]initWithSize:3];

    // Overload the middle
    CoOrdinate* move = [[CoOrdinate alloc]initWithX:1 Y:1];
    
    [self overloadAt:move onBoard:board withColour:white andLimit:4 forTest:@"explodeCellEdge"];
    
    // Pre-explosion, square is white - black move invalid
    STAssertFalse([board isValidMoveAt:(move) withColour:(black)], @"Black move on white square is invalid");

    [board handleExplosionAt:move ofColour:white];
    
    [self assertAdjacent:move onBoard:board withColour:white forTest:@"explodeCellEdge"];
    
}

-(void)testExplodeCellSide {
    // Create a clean board
    Board *board = [[Board alloc]initWithSize:3];
    
    // Overload the middle
    CoOrdinate* move = [[CoOrdinate alloc]initWithX:1 Y:0];
    [self overloadAt:move onBoard:board withColour:white andLimit:3 forTest:@"explodeCellSide"];
    
    // Pre-explosion, square is white - black move invalid
    STAssertFalse([board isValidMoveAt:(move) withColour:(black)], @"Black move on white square is invalid");
    
    [board handleExplosionAt:move ofColour:white];
    
    [self assertAdjacent:move onBoard:board withColour:white forTest:@"explodeCellSide"];

}

-(void)testExplodeCellEdge {
    // Create a clean board
    Board *board = [[Board alloc]initWithSize:3];
    
    // Overload the middle
    CoOrdinate* move = [[CoOrdinate alloc]initWithX:0 Y:0];
    [self overloadAt:move onBoard:board withColour:white andLimit:2 forTest:@"explodeCellEdge"];
    
    // Pre-explosion, square is white - black move invalid
    STAssertFalse([board isValidMoveAt:(move) withColour:(black)], @"Black move on white square is invalid");
    
    [board handleExplosionAt:move ofColour:white];

    [self assertAdjacent:move onBoard:board withColour:white forTest:@"explodeCellEdge"];
}

// The board doesnt know the rules of the game, but it can tell you if all placed pieces are the same colour, and which colour that is
-(void)testPiecesSameColourEmptyBoard {
    // Create a clean board
    Board *board = [[Board alloc]initWithSize:3];
    
    STAssertFalse([board areAllPieces:black], @"All pieces should not be black after no turns");
    STAssertFalse([board areAllPieces:white], @"All pieces should not be white after no turns");
    
}

// Empty board, put black piece down, check all pieces are registered as black
-(void)testPiecesSameColourJustBlack {
    // Create a clean board
    Board *board = [[Board alloc]initWithSize:3];

    CoOrdinate* move = [[CoOrdinate alloc]initWithX:1 Y:1];
    [board placePieceAt:move ofColour:black];
    
    STAssertTrue([board areAllPieces:black], @"All pieces should be black");
    STAssertFalse([board areAllPieces:white], @"All pieces should be black");
}

// Empty board, put black piece down, check all pieces are registered as black
-(void)testPiecesSameColourJustWhite {
    // Create a clean board
    Board *board = [[Board alloc]initWithSize:3];
    
    CoOrdinate* move = [[CoOrdinate alloc]initWithX:1 Y:1];
    [board placePieceAt:move ofColour:white];
    
    STAssertTrue([board areAllPieces:white], @"All pieces should be white");
    STAssertFalse([board areAllPieces:black], @"All pieces should be white");
}

-(void)testPiecesSameColourOverload{
    // Create a clean board
    Board *board = [[Board alloc]initWithSize:3];
    
    // We will overload here
    CoOrdinate* move = [[CoOrdinate alloc]initWithX:1 Y:1];
    
    // Place black pieces around this square - these will ultimately be overloaded on to
    [board placePieceAt:[move left] ofColour:black];
    [board placePieceAt:[move right] ofColour:black];
    [board placePieceAt:[move above] ofColour:black];
    [board placePieceAt:[move below] ofColour:black];
    
    // Only black on the board, check that;
    STAssertTrue([board areAllPieces:black], @"All pieces should be black");
    
    // Place piece at original location
    [board placePieceAt:move ofColour:white];

    // White & black on the board, check that;
    STAssertFalse([board areAllPieces:black], @"All pieces should not be black");
    STAssertFalse([board areAllPieces:white], @"All pieces should not be white");

    // Overload cell (only 3 because we've already placed a piece once, 3 left to overload)
    [self overloadAt:move onBoard:board withColour:white andLimit:3 forTest:@"testPiecesSameColourOverload"];
    
    // Got here, so overloaded - tell board to explode cell
    [board handleExplosionAt:move ofColour:white];
    
    // Overload should have landed on all black squares, so all pieces should now be white
    STAssertTrue([board areAllPieces:white], @"All pieces should be white");
    
}

#pragma mark utility methods

// Tests that adjacent cells are set to the appropriate colour after explosion
-(void)assertAdjacent:(CoOrdinate*)move onBoard:(Board*)board withColour:(Colours)colour forTest:(NSString*)test {
    
    Colours otherColour = colour==white?black:white;
    
    // Should now be nothing in original square
    STAssertTrue([board isValidMoveAt:(move) withColour:(otherColour)], @"After explosion, should be able to put other colour on previously colour. Test=%@",test);
    // And original colour in adjacent
    STAssertFalse([board isValidMoveAt:[move left] withColour:otherColour], @"left of original space should be %d so %d move is illegal. Test=%@", colour, otherColour, test);
    // And original colour in adjacent
    STAssertFalse([board isValidMoveAt:[move right] withColour:otherColour], @"right of original space should be %d so %d move is illegal. Test=%@", colour, otherColour,test);
    // And original colour in adjacent
    STAssertFalse([board isValidMoveAt:[move above] withColour:otherColour], @"above of original space should be %d so %d move is illegal. Test=%@", colour, otherColour,test);
    // And original colour in adjacent
    STAssertFalse([board isValidMoveAt:[move below] withColour:otherColour], @"below of original space should be %d so %d move is illegal. Test=%@", colour, otherColour,test);
}

// Overloads a cell with a colour.  Checks that its not overloaded
-(void)overloadAt:(CoOrdinate*)move onBoard:(Board*)board withColour:(Colours)colour andLimit:(int)limit forTest:(NSString*)test {

    BOOL overloaded = false;
    for (int o=1 ; o<=limit ; o++){
        // Place piece and returns if move causes overload
        overloaded = [board placePieceAt:(move) ofColour:(colour)];
        // If on limit, assert overloaded
        if (o==limit){
            STAssertTrue(overloaded, @"Cell should be overloaded after %d turns. Test=%@", o, test);
        } else {
            STAssertFalse(overloaded, @"Cell should not be overloaded after %d turns. Test=%@", o, test);
        }
        
    }
    
}
@end
