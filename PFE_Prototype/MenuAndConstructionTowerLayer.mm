//
//  MenuAndConstructionTowerLayer.m
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 17/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "MenuAndConstructionTowerLayer.h"


@implementation MenuAndConstructionTowerLayer

@synthesize pTowerLayer = _pTowerLayer;
@synthesize pMenuLayer = _pMenuLayer;
@synthesize pPlanetLayer = _pPlanetLayer;

-(id) initWithTowerData : (TowerData*) i_pTowerData HeightWin:(int)win
{
    if (self = [super init])
    {
        
        [self setTouchEnabled:YES];
        
        _pPlanetLayer = [PlanetLayer node];
        _pMenuLayer = [MenuLayer node];
        _pTowerLayer = [[[ConstructionTowerLayer alloc] initWithTowerData:i_pTowerData WinningHeight:win] autorelease];
        
        _pMenuLayer.delegate = self;
        _pTowerLayer.delegate = self;
        
        [self addChild:_pPlanetLayer];
        [self addChild:_pTowerLayer];
        [self addChild:_pMenuLayer];
    }
    
    return self;
}

-(void)BlocHasBeenSelected:(BlocData*)blocSelected
{
    [_pTowerLayer menuSendOneBloc:blocSelected];
}

-(void)movePlanet:(int)height
{
    CCAction* pMoveTo = [CCMoveTo actionWithDuration:0.2 position:ccp(_pPlanetLayer.position.x, _pPlanetLayer.position.y - height)];
    [_pPlanetLayer runAction:pMoveTo];
}

@end
