//
//  BalanceTowerLayer.m
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 27/12/2013.
//  Copyright 2013 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "BalanceTowerLayer.h"


@implementation BalanceTowerLayer

@synthesize towerData = _towerData;
@synthesize aBlocsTowerSprite = _aBlocsTowerSprite;

-(id) initWithTowerData : (TowerData*) i_pTowerData
{
    if (self = [super init])
    {
        _towerData = i_pTowerData;
        _aBlocsTowerSprite = [[[NSMutableArray alloc] init] autorelease];
    }
    
    return self;
}


@end
