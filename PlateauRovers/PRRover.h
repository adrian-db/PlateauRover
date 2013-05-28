//
//  PRRover.h
//  PlateauRovers
//
//  Created by Adrian Bigland on 28/05/2013.
//  Copyright (c) 2013 Adrian Bigland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRGeometry.h"

typedef enum {
    kPRoverOrientationNorth,
    kPRoverOrientationSouth,
    kPRoverOrientationEast,
    kPRoverOrientationWest
} PRoverOrientation;

FOUNDATION_EXPORT const int DEFAULT_X_CO_ORD;
FOUNDATION_EXPORT const int DEFAULT_Y_CO_ORD;
FOUNDATION_EXPORT const PRoverOrientation DEFAULT_ORIENTATION;

/**
 A mobile robot, that can explore a rectangular plateau.
 */
@interface PRRover : NSObject

@property (nonatomic, assign) PRPlateauPoint location;
@property (nonatomic, assign) PRoverOrientation orientation;

- (id)initWithX:(int)x andY:(int)y andOrientation:(PRoverOrientation)orientation;

/**
 The point that this rover will move into, if it moves forwards on its current heading.
 Note that this may be off the edge of the plateau.
 */
- (PRPlateauPoint)targetPoint;

- (void)turnRight;
- (void)turnLeft;

+ (NSString *)describeOrientation:(PRoverOrientation)orientation;

@end
