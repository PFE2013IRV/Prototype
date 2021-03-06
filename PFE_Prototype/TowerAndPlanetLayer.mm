//
//  TowerAndPlanetLayer.m
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 27/12/2013.
//  Copyright 2013 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "TowerAndPlanetLayer.h"


@implementation TowerAndPlanetLayer

@synthesize pPlanetLayer = _pPlanetLayer;
@synthesize balanceTower = _balanceTower;
@synthesize TowerSize;

-(id) initWithGameData : (GameData*) i_pGameData PlanetLayer: (PlanetLayer*) i_pPlanet
{
    if (self = [super init])
    {
        i_pPlanet = i_pPlanet;
        [self addChild:i_pPlanet];
        i_pPlanet.delegate = self;
        [i_pPlanet launchBalanceModeForPlanet];
        
        _balanceTower = [[[BalanceTowerLayer alloc] initWithTowerData:i_pGameData._pTowerData] autorelease];
        _balanceTower.TowerSize = TowerSize;
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
