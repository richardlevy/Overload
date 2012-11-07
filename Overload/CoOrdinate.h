//
//  CoOrdinate.h
//  Overload
//
//  Created by Richard Levy on 05/11/2012.
//  Copyright (c) 2012 Richard Levy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoOrdinate : NSObject

@property int x;
@property int y;

-(id)initWithX:(int)newX Y:(int)newY;

-(CoOrdinate*)above;
-(CoOrdinate*)below;
-(CoOrdinate*)left;
-(CoOrdinate*)right;
@end
