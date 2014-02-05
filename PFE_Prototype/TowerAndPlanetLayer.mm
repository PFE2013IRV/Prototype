//
//  TowerAndPlanetLayer.m
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 27/12/2013.
//  Copyright 2013 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "TowerAndPlanetLayer.h"


@implementation TowerAndPlanetLayer

@synthesize planet = _planet;
@synthesize balanceTower = _balanceTower;

-(id) initWithGameData : (GameData*) i_pGameData PlanetLayer: (PlanetLayer*) i_pPlanet
{
    if (self = [super init])
    {
        _planet = i_pPlanet;
        [self addChild:_planet];
        _planet.delegate = self;
        [_planet launchBalanceModeForPlanet];
        
        _balanceTower = [[[BalanceTowerLayer alloc] initWithTowerData:i_pGameData._pTowerData] autorelease];
        [self addChild:_balanceTower];
    }
    
    return self;
}

-(void)hasRotate:(int)degrees;
{
    //NSLog(@"planet has rotate of %d degrees", degrees);
     NSNumber* dataNum = [NSNumber numberWithInt:degrees];
    [_balanceTower rotateGroundWorld:nil data:dataNum];
}

@end
