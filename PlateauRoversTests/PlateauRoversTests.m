//
//  PlateauRoversTests.m
//  PlateauRoversTests
//
//  Created by Adrian Bigland on 28/05/2013.
//  Copyright (c) 2013 Adrian Bigland. All rights reserved.
//

#import "PlateauRoversTests.h"
#import "PRRover.h"
#import "PRParser.h"
#import "PRConstants.h"

@implementation PlateauRoversTests

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

/**
 Checks that moving forwards gets you to the expected location.
 */
- (void)testTargetPointZeroZeroNorth
{
    PRRover *rover = [[PRRover alloc] init];
    
    PRPlateauPoint expected = PRMakePlateauPoint(0, 1);
    
    PRPlateauPoint actual = [rover targetPoint];
    
    STAssertEquals(actual.x, expected.x, @"Failed to move to the expected target point when going forwards.");
    STAssertEquals(actual.y, expected.y, @"Failed to move to the expected target point when going forwards.");
    
    [rover release];
}

/**
 Checks that moving forwards gets you to the expected location.
 */
- (void)testTargetPointZeroZeroEast
{
    PRRover *rover = [[PRRover alloc] initWithX:0 andY:0 andOrientation:kPRoverOrientationEast];
    
    PRPlateauPoint expected = PRMakePlateauPoint(1, 0);
    
    PRPlateauPoint actual = [rover targetPoint];
    
    STAssertEquals(actual.x, expected.x, @"Failed to move to the expected target point when going forwards.");
    STAssertEquals(actual.y, expected.y, @"Failed to move to the expected target point when going forwards.");
    
    [rover release];
}

/**
 Checks that moving forwards gets you to the expected location.
 */
- (void)testTargetPointZeroZeroWest
{
    PRRover *rover = [[PRRover alloc] initWithX:0 andY:0 andOrientation:kPRoverOrientationWest];
    
    PRPlateauPoint expected = PRMakePlateauPoint(-1, 0);
    
    PRPlateauPoint actual = [rover targetPoint];
    
    STAssertEquals(actual.x, expected.x, @"Failed to move to the expected target point when going forwards.");
    STAssertEquals(actual.y, expected.y, @"Failed to move to the expected target point when going forwards.");
    
    [rover release];
}

/**
 Checks that moving forwards gets you to the expected location.
 */
- (void)testTargetPointZeroZeroSouth
{
    PRRover *rover = [[PRRover alloc] initWithX:0 andY:0 andOrientation:kPRoverOrientationSouth];
    
    PRPlateauPoint expected = PRMakePlateauPoint(0, -1);
    
    PRPlateauPoint actual = [rover targetPoint];
    
    STAssertEquals(actual.x, expected.x, @"Failed to move to the expected target point when going forwards.");
    STAssertEquals(actual.y, expected.y, @"Failed to move to the expected target point when going forwards.");
    
    [rover release];
}

/**
 Checks that the parser correctly parses a top right plateau co-ordinate.
 */
- (void)testParserLine1Correct
{
    PRParser *parser = [[PRParser alloc] init];
    
    NSError *error = nil;
    PRPlateauPoint actual = [parser parsePlateauPoint:@"3 5" withError:&error];
    
    STAssertNil(error, @"Encountered an error parsing a correct co-ordinate string");
    
    PRPlateauPoint expected = PRMakePlateauPoint(3, 5);
    
    STAssertEquals(actual.x, expected.x, @"Failed to parse the correct x co-ordinate.");
    STAssertEquals(actual.y, expected.y, @"Failed to parse the correct y co-ordinate.");
    
    [parser release];
}

/**
 Checks that the parser returns an error when given an input line that doesn't contain a co-ordinate.
 */
- (void)testParserLine1NotANumber
{
    PRParser *parser = [[PRParser alloc] init];
    
    NSError *error = nil;
    [parser parsePlateauPoint:@"3 foo" withError:&error];
    
    STAssertNotNil(error, @"Encountered an error parsing a correct co-ordinate string");
    STAssertEquals(error.code, PR_ERROR_CODE_BAD_POINT, @"Wrong error code for a string with no co-ordinate.");
    
    [parser release];
}

/**
 Checks that the parser returns an error when given an input line that doesn't contain a co-ordinate.
 */
- (void)testParserLineOnlyOne
{
    PRParser *parser = [[PRParser alloc] init];
    
    NSError *error = nil;
    [parser parsePlateauPoint:@"3" withError:&error];
    
    STAssertNotNil(error, @"Encountered an error parsing a correct co-ordinate string");
    STAssertEquals(error.code, PR_ERROR_CODE_BAD_POINT, @"Wrong error code for a string with no co-ordinate.");
    
    [parser release];
}

/**
 Checks that a well formed rover description is parsed as expected.
 */
- (void)testParserRoverCorrect
{
    PRParser *parser = [[PRParser alloc] init];
    
    NSError *error = nil;
    PRRover *actual = [parser parseRover:@"1 3 N" withError:&error];
    
    STAssertNil(error, @"Failed to parse a correct rover specification.");
    STAssertEquals(actual.location.x, 1, @"Parsed the wrong x co-ordinate.");
    STAssertEquals(actual.location.y, 3, @"Parsed the wrong y co-ordinate.");
    STAssertEquals(actual.orientation, kPRoverOrientationNorth, @"Parsed the wrong orientation.");
    
    [parser release];
}

/**
 Checks that a well formed rover description is parsed as expected.
 */
- (void)testParserRoverCorrectButLowercase
{
    PRParser *parser = [[PRParser alloc] init];
    
    NSError *error = nil;
    PRRover *actual = [parser parseRover:@"1 3 s" withError:&error];
    
    STAssertNil(error, @"Failed to parse a correct rover specification.");
    STAssertEquals(actual.location.x, 1, @"Parsed the wrong x co-ordinate.");
    STAssertEquals(actual.location.y, 3, @"Parsed the wrong y co-ordinate.");
    STAssertEquals(actual.orientation, kPRoverOrientationSouth, @"Parsed the wrong orientation.");
    
    [parser release];
}

/**
 Checks that a well formed rover description is parsed as expected.
 */
- (void)testParserRoverCorrectButPaddedWithWhitespace
{
    PRParser *parser = [[PRParser alloc] init];
    
    NSError *error = nil;
    PRRover *actual = [parser parseRover:@"5    0   E" withError:&error];
    
    STAssertNil(error, @"Failed to parse a correct rover specification.");
    STAssertEquals(actual.location.x, 5, @"Parsed the wrong x co-ordinate.");
    STAssertEquals(actual.location.y, 0, @"Parsed the wrong y co-ordinate.");
    STAssertEquals(actual.orientation, kPRoverOrientationEast, @"Parsed the wrong orientation.");
    
    [parser release];
}

/**
 Checks that a badly formed rover description is parsed and gives the expected error.
 */
- (void)testParserRoverEmpty
{
    PRParser *parser = [[PRParser alloc] init];
    
    NSError *error = nil;
    [parser parseRover:@"        " withError:&error];
    
    STAssertNotNil(error, @"Parsed a badly formed rover description.");
    STAssertEquals(error.code, PR_ERROR_CODE_BAD_POINT, @"Got an unexpected error code when parsing a rover description with a bad co-ordinate.");
    
    [parser release];
}

/**
 Checks that a badly formed rover description is parsed and gives the expected error.
 */
- (void)testParserRoverBadOrientation
{
    PRParser *parser = [[PRParser alloc] init];
    
    NSError *error = nil;
    [parser parseRover:@"1 3 Foo" withError:&error];
    
    STAssertNotNil(error, @"Parsed a badly formed rover description.");
    STAssertEquals(error.code, PR_ERROR_CODE_BAD_ORIENTATION, @"Got an unexpected error code when parsing a rover description with a bad orientation.");
    
    [parser release];
}

@end
