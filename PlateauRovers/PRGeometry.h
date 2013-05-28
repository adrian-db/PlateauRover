//
//  PRGeometry.h
//  PlateauRovers
//
//  Created by Adrian Bigland on 28/05/2013.
//  Copyright (c) 2013 Adrian Bigland. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct _PRPlateauPoint {
    
    int x;
    int y;
    
} PRPlateauPoint;

PRPlateauPoint PRMakePlateauPoint(int x, int y);