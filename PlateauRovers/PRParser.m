//
//  PRParser.m
//  PlateauRovers
//
//  Created by Adrian Bigland on 28/05/2013.
//  Copyright (c) 2013 Adrian Bigland. All rights reserved.
//

#import "PRParser.h"
#import "PRConstants.h"
#import "PRRover.h"

@implementation PRParser

- (PRPlateauPoint)parsePlateauPoint:(NSString *)text withError:(NSError **)error
{
    NSScanner *scanner = [NSScanner scannerWithString:text];
    
    PRPlateauPoint point;
    
    if (!([scanner scanInt:&point.x] && [scanner scanInt:&point.y])) {
        
        if (error != NULL) {
            *error = [NSError errorWithDomain:PR_ERROR_DOMAIN_PARSING code:PR_ERROR_CODE_BAD_POINT userInfo:nil];
        }
        
    }
    
    return point;
}

- (PRRover *)parseRover:(NSString *)text withError:(NSError **)error
{
    NSScanner *scanner = [NSScanner scannerWithString:text];
    
    PRPlateauPoint location;
    
    if (!([scanner scanInt:&location.x] && [scanner scanInt:&location.y])) {
        
        if (error != NULL) {
            *error = [NSError errorWithDomain:PR_ERROR_DOMAIN_PARSING code:PR_ERROR_CODE_BAD_POINT userInfo:nil];
        }
        return nil;
        
    }
    
    NSString *orientationText = nil;
    [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet] intoString:&orientationText];

    if (orientationText == nil || orientationText.length != 1) {
        
        if (error != NULL) {
            *error = [NSError errorWithDomain:PR_ERROR_DOMAIN_PARSING code:PR_ERROR_CODE_BAD_ORIENTATION userInfo:nil];
        }
        return nil;
        
    }
    
    orientationText = [orientationText lowercaseString];
    
    PRoverOrientation orientation;
    if ([orientationText isEqualToString:@"n"]) {
        
        orientation = kPRoverOrientationNorth;
        
    }
    else if ([orientationText isEqualToString:@"s"]) {
        
        orientation = kPRoverOrientationSouth;
        
    }
    else if ([orientationText isEqualToString:@"e"]) {
        
        orientation = kPRoverOrientationEast;
        
    }
    else if ([orientationText isEqualToString:@"w"]) {
        
        orientation = kPRoverOrientationWest;
        
    }
    else {
        
        if (error != NULL) {
            *error = [NSError errorWithDomain:PR_ERROR_DOMAIN_PARSING code:PR_ERROR_CODE_BAD_ORIENTATION userInfo:nil];
        }
        return nil;
        
    }
    
    PRRover *rover = [[PRRover alloc] initWithX:location.x andY:location.y andOrientation:orientation];
    
    return [rover autorelease];
}

@end
