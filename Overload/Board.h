//
//  Board.h
//  Overload
//
//  Created by Richard Levy on 05/11/2012.
//  Copyright (c) 2012 Richard Levy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cell.h"
#import "CoOrdinate.h"

static const int LIMIT_EDGE=2;
static const int LIMIT_SIDE=3;
static const int LIMIT_MIDDLE=4;

@interface Board : NSObject {
    @private
    int size;
    NSMutableArray *board;
}

-(id)initWithSize:(int)size;

// Checks whether a move is allowed
-(BOOL)isValidMoveAt:(CoOrdinate*)move withColour:(Colours)colour;

// Returns true if cell is overloaded after play
-(BOOL)placePieceAt:(CoOrdinate*)move ofColour:(Colours)colour;

// Explosion handler for cascading explosion
-(BOOL)handleExplosionAt:(CoOrdinate*)move ofColour:(Colours)colour;

// Determine if all pieces on the board are the same colour
-(BOOL)areAllPieces:(Colours)colour;

@end
