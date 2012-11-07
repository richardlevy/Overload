//
//  Overload.m
//  Overload
//
//  Created by Richard Levy on 06/11/2012.
//  Copyright (c) 2012 Richard Levy. All rights reserved.
//
// Because this is the main game class, and doesnt therefore need to expose methods, i'll make everything public so it can be tested.
//
// Also, this could be more OO.  We could have a player class and get moves from that.  But the point of this exercise is not the ultimate solution.

#import "Overload.h"
#import "CoOrdinate.h"

@implementation Overload

@synthesize turnCounter;

-(id)init {
    self=[super init];
    if (self!=nil){
        self.turnCounter=0;
        // Create new board of the defined size
        board = [[Board alloc]initWithSize:BOARD_SIZE];
        // White goes first
        player=white;
    }
    
    return self;
}

// Play the game until there's a winner.  White goes first, each player makes random plays
-(void)playGame {
    Colours winningColour=none;
    do {
        // Increment the turn counter
        self->turnCounter++;

        // Get a random move
        CoOrdinate* move = [self getValidMoveForColour:player];
        
        // Make the move - returns true if move causes overload
        if ([board placePieceAt:move ofColour:player]) {
            // Overloaded - explode cell.  Returns true if at end of explosions, board is all one colour
            if ([board handleExplosionAt:move ofColour:player]) {
                NSLog(@"Explosion....");
                // As long as there's been one turn each
                if (turnCounter > 1) {
                    winningColour = player;
                }
            }
        }
        // Display board
        NSLog(@"#%d - Player #%d put piece at %d, %d.  Board = %@", self->turnCounter, player, move.x, move.y, board);

        // Switch player
        player = player==white?black:white;
        
    } while (winningColour==none);
    
    NSLog(@"Winning colour is %d in %d turns", winningColour, turnCounter);

}

#pragma mark private methods

// Returns a valid move for the specified colour
-(CoOrdinate*)getValidMoveForColour:(Colours)colour {
    CoOrdinate* move;
    do {
        move = [self getRandomMove];
    } while (![board isValidMoveAt:move withColour:colour]);
    
    return move;
}

// Returns a random move
-(CoOrdinate*)getRandomMove {
    return [[CoOrdinate alloc]initWithX:arc4random() % BOARD_SIZE Y:arc4random() % BOARD_SIZE];
}
@end
