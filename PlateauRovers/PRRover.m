//
//  PRRover.m
//  PlateauRovers
//
//  Created by Adrian Bigland on 28/05/2013.
//  Copyright (c) 2013 Adrian Bigland. All rights reserved.
//

#import "PRRover.h"

const int DEFAULT_X_CO_ORD = 0;
const int DEFAULT_Y_CO_ORD = 0;
const PRoverOrientation DEFAULT_ORIENTATION = kPRoverOrientationNorth;

@implementation PRRover

@synthesize location = _location;
@synthesize orientation = _orientation;

- (id)init
{
    return [self initWithX:DEFAULT_X_CO_ORD andY:DEFAULT_Y_CO_ORD andOrientation:DEFAULT_ORIENTATION];
}

- (id)initWithX:(int)x andY:(int)y andOrientation:(PRoverOrientation)orientation
{
    self = [super init];
    
    if (self) {
        
        self.location = PRMakePlateauPoint(x, y);
        self.orientation = orientation;
        
    }
    
    return self;
}

- (PRPlateauPoint)targetPoint
{
    int xDelta = 0;
    int yDelta = 0;
    
    switch (self.orientation) {
            
        case kPRoverOrientationNorth:
            yDelta = 1;
            break;
            
        case kPRoverOrientationSouth:
            yDelta = -1;
            break;
            
        case kPRoverOrientationEast:
            xDelta = 1;
            break;
            
        case kPRoverOrientationWest:
            xDelta = -1;
            break;
            
        default:
            break;
            
    }
    
    return PRMakePlateauPoint(self.location.x + xDelta, self.location.y + yDelta);
};

- (void)turnRight
{
    switch (self.orientation) {
        case kPRoverOrientationNorth:
            self.orientation = kPRoverOrientationEast;
            break;
            
        case kPRoverOrientationEast:
            self.orientation = kPRoverOrientationSouth;
            break;
            
        case kPRoverOrientationSouth:
            self.orientation = kPRoverOrientationWest;
            break;
            
        case kPRoverOrientationWest:
            self.orientation = kPRoverOrientationNorth;
            break;
            
        default:
            break;
    }
}

- (void)turnLeft
{
    switch (self.orientation) {
        case kPRoverOrientationNorth:
            self.orientation = kPRoverOrientationWest;
            break;
            
        case kPRoverOrientationEast:
            self.orientation = kPRoverOrientationNorth;
            break;
            
        case kPRoverOrientationSouth:
            self.orientation = kPRoverOrientationEast;
            break;
            
        case kPRoverOrientationWest:
            self.orientation = kPRoverOrientationSouth;
            break;
            
        default:
            break;
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%i %i %@", self.location.x, self.location.y, [PRRover describeOrientation:self.orientation]];
}

+ (NSString *)describeOrientation:(PRoverOrientation)orientation
{
    switch (orientation) {
        case kPRoverOrientationNorth:
            return @"N";
            
        case kPRoverOrientationEast:
            return @"E";
            
        case kPRoverOrientationSouth:
            return @"S";
            
        case kPRoverOrientationWest:
            return @"W";
    }
}

@end
