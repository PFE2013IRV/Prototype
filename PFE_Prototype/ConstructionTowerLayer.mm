//
//  ConstructionTowerLayer.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 16/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "ConstructionTowerLayer.h"


@implementation ConstructionTowerLayer

-(id) initWithTowerData:(TowerData*) i_pTowerData
{
    if (self = [super init])
    {
        self._pTowerData = i_pTowerData;
    }
    
    return self;
}

@end
