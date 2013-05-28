//
//  PRParser.h
//  PlateauRovers
//
//  Created by Adrian Bigland on 28/05/2013.
//  Copyright (c) 2013 Adrian Bigland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRGeometry.h"
#import "PRRover.h"

@interface PRParser : NSObject

/**
 Parses the initial line, giving the top right position of the plateau.
 */
- (PRPlateauPoint)parsePlateauPoint:(NSString *)text withError:(NSError **)error;

/**
 Parses a line describing the initial position and orientation of a rover.
 */
- (PRRover *)parseRover:(NSString *)text withError:(NSError **)error;

@end
