//
//  main.m
//  PlateauRovers
//
//  Created by Adrian Bigland on 28/05/2013.
//  Copyright (c) 2013 Adrian Bigland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRParser.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSFileHandle *stdin = [NSFileHandle fileHandleWithStandardInput];
        NSData *data = [stdin readDataToEndOfFile];
        
        NSString *content = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
        
        NSLog(@"Read: %@", content);
        
        NSArray *lines = [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        [content release];
        
        if (lines == nil || [lines count] < 1) {
            
            return 0;
            
        }
        
        NSString *firstLine = [lines objectAtIndex:0];
        
        PRParser *parser = [[PRParser alloc] init];
        
        NSError *error;
        PRPlateauPoint topLeftPoint = [parser parsePlateauPoint:firstLine withError:&error];
        
        if (error != nil) {
            
            NSLog(@"Expected a point in line 1 (the co-ordinates of the top left of the plateau, but got: %@", firstLine);
            [parser release];
            return -1;
            
        }
        
        // Start on the line after the plateau size.
        int currentLineIndex = 1;
        
        while (currentLineIndex < [lines count]) {
            
            NSString *nextLine = [lines objectAtIndex:currentLineIndex];
            
            // Skip any empty lines, just to make the parser a bit less strict.
            if ([[nextLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
                
                ++currentLineIndex;
                continue;
                
            }
            
            // Try and parse a robot initialisation line.
            PRRover *rover = [parser parseRover:nextLine withError:&error];
            if (rover == nil) {
                
                NSLog(@"Got a badly formed rover description at line %i: %@, giving error: %@", currentLineIndex + 1, nextLine, error);
                [parser release];
                return -1;
                
            }
            
            ++currentLineIndex;
            while (currentLineIndex < [lines count]) {
                
                nextLine = [lines objectAtIndex:currentLineIndex];
                nextLine = [nextLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                nextLine = [nextLine lowercaseString];
                
                // Skip any empty lines, just to make the parser a bit less strict.
                if ([nextLine length] == 0) {
                    
                    ++currentLineIndex;
                    continue;
                    
                }
                
                // If we find a line of content, parse it as instructions to the rover.
                int i;
                for (i = 0; i < nextLine.length; ++i) {
                    
                    unichar c = [nextLine characterAtIndex:i];
                    
                    if (c == 'l') {
                        
                        [rover turnLeft];
                        
                    }
                    else if (c == 'r') {
                        
                        [rover turnRight];
                        
                    }
                    else if (c == 'm') {
                        
                        PRPlateauPoint target = [rover targetPoint];
                        
                        // Don't move forwards if we would go off the edge of the plateau.
                        // TODO: should it be an error to send a robot to its doom?
                        if (target.x < 0 || target.x > topLeftPoint.x) continue;
                        if (target.y < 0 || target.y > topLeftPoint.y) continue;
                        
                        // Otherwise, move to the target location.
                        rover.location = target;
                        
                    }
                    else {
                        
                        NSLog(@"Badly formed instructions line at line %i: %@", currentLineIndex + 1, nextLine);
                        [parser release];
                        return -1;
                        
                    }
                }
                
                ++currentLineIndex;
                break;
                
            }
            
            // Print out the final state of the rover, and continue.
            NSLog(@"%@", rover);
        }
        
        [parser release];
        
    }
    return 0;
}

