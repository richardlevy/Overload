//
//  Board.m
//  Overload
//
//  Created by Richard Levy on 05/11/2012.
//  Copyright (c) 2012 Richard Levy. All rights reserved.
//

#import "Board.h"
#import "Cell.h"

@implementation Board

// Create a square board of size defined
-(id)initWithSize:(int)newSize {
    self = [super init];
    if (self!=nil){
        self->size=newSize;
        
        // Initialise the board - use a mutable array because i want the size as a parameter, otherwise we'd use an array!
        self->board = [[NSMutableArray alloc]initWithCapacity:(newSize*newSize)];

        // Fill with empty cells
        [self cleanBoard];
    }
    
    return self;
}

// Determines if its valid to make a play
-(BOOL)isValidMoveAt:(CoOrdinate *)move withColour:(Colours)colour {
    if ([self isOnBoardAtX:move.x Y:move.y]) {
        Cell* cell = [self getCellAtX:move.x Y:move.y];
    
        // Return true if the cell is empty, or the colour being played
        return [cell isEmpty] || [cell isColour:(colour)];
    } else {
        return false;
    }
}

// Places a piece at the specified location of the specified colour
-(BOOL)placePieceAt:(CoOrdinate *)move ofColour:(Colours)colour {
    // By ignoring out of bound plays, we can place anywhere without fear.  This is handy when we explode a cell and put stuff on adjacent squares - no need to check where to place, just do all four!
    if (move.x>=0 & move.y>=0 & move.x<self->size & move.y<self->size){
        Cell* cell = [self getCellAtX:move.x Y:move.y];
        [cell addPieceOfColour:colour];
        return [cell isOverloaded];
    } else {
        return false;}
}

// Returns true if game is over
// Note that full cascade will occur.  This is desirable to completely model the affect of placing a piece
// See cascadeExplosionAt method for where to check for game over if you want to stop cascading when the game is won
-(BOOL)handleExplosionAt:(CoOrdinate *)move ofColour:(Colours)colour {
    Cell* cell = [self getCellAtX:move.x Y:move.y];

    assert([cell isOverloaded]);
    
    // Reset this piece
    [cell reset];

    //  No need to determine the cell type, just call the 4 adjacent cells around.
    [self cascadeExplosionAt:[move above] ofColour:colour];
    [self cascadeExplosionAt:[move below] ofColour:colour];
    [self cascadeExplosionAt:[move left] ofColour:colour];
    [self cascadeExplosionAt:[move right] ofColour:colour];
    
    return [self areAllPieces:colour];
}

// Checks that all pieces placed on the board are the same colour.
-(BOOL)areAllPieces:(Colours)colour{
    int x,y;
    Cell* cell;
    BOOL requiredColourFound=false;
    Colours otherColour=colour==white?black:white;
    for (int i=0 ; i < (self->size*self->size) ; i++) {
        x = i / self->size;
        y = i % self->size;
        
        cell = [self getCellAtX:x Y:y];
        
        if (![cell isEmpty]) {
            if ([cell isColour:otherColour]){
                return false;
            } else {
                // Important step - have found one of the colour requested
                requiredColourFound=true;
            }
        }
    }
    return requiredColourFound;
}

-(NSString*)description{
    int x,y;
    Cell* cell;
    NSMutableString *boardStr = [[NSMutableString alloc]init];
    
    for (int i=0 ; i < (self->size*self->size) ; i++) {
        x = i / self->size;
        y = i % self->size;
        
        // Newline at the start of a new line
        if (y==0){
            [boardStr appendString:@"\n"];
        }
        
        cell = [self getCellAtX:x Y:y];
        [boardStr appendString:[cell description]];        
        
    }
    
    return boardStr;
}

#pragma mark private methods

// Cascade explosion
-(void) cascadeExplosionAt:(CoOrdinate*)move ofColour:(Colours)colour{
    // Check for game over.
    // We could stop exploding here if the game is won, but I think that's moving behaviour into this class then really it should just return status.

    // Set adjacent piece to this colour
    if ([self placePieceAt:move ofColour:colour]) {
        [self handleExplosionAt:move ofColour:colour];
    }
}

// Fills the board with new cells
// Todo - what memory management here
-(void)cleanBoard {
    Cell *newCell;
    int x,y;
    for (int i=0 ; i < (self->size*self->size) ; i++) {
        x = i / self->size;
        y = i % self->size;
        
        if ([self isEdgeAtX:x Y:y]) {
            newCell = [[Cell alloc]initWithLimit:LIMIT_EDGE];
        } else if ([self isSideAtX:x Y:y]){
            newCell = [[Cell alloc]initWithLimit:LIMIT_SIDE];
        } else {
            newCell = [[Cell alloc]initWithLimit:LIMIT_MIDDLE];
        }
        [board insertObject:newCell atIndex:i];
    }
    
}

// Returns the cell at the specified location
-(Cell*)getCellAtX:(int)x Y:(int)y{
    return [board objectAtIndex:(x*self->size)+y];
}

// Edge is the corner
-(BOOL)isEdgeAtX:(int)x Y:(int)y {
    BOOL edge = (x==0) & (y==0);
    edge |= ((x==0) & (y==self->size));
    edge |= (x==self->size-1) & (y==0);
    edge |= (x==self->size-1) & (y==0);
    
    return edge;
 }

// Side is the side, but not the corner/edge
-(BOOL)isSideAtX:(int)x Y:(int)y {
    if (![self isEdgeAtX:x Y:y]){
        return x==0 || y==0 || x==self->size-1 || y==self->size-1;
    } else {
        return false;
    }
}

// Youre at the middle if youre not at the edge or the side
-(BOOL)isMiddleAtX:(int)x Y:(int)y {
    BOOL edge = [self isEdgeAtX:x Y:y];
    BOOL side = [self isSideAtX:x Y:y];
    
    return !edge & !side;
}

-(BOOL)isOnBoardAtX:(int)x Y:(int)y {
    return !(x<0 || y<0 || x>=self->size || y >= self->size);
}
                   
@end
