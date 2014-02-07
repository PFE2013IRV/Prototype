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

-(id) initWithTowerData : (TowerData*) i_pTowerData HeightWin:(int)win
{
    if (self = [super init])
    {
        
        [self setTouchEnabled:YES];
        
        _pMenuLayer = [MenuLayer node];
        _pTowerLayer = [[[ConstructionTowerLayer alloc] initWithTowerData:i_pTowerData WinningHeight:win] autorelease];
        
        _pMenuLayer.delegate = self;
        _pTowerLayer.delegate = self;
        
        [self addChild:_pTowerLayer];
        [self addChild:_pMenuLayer];
    }
    
    return self;
}

-(void)BlocHasBeenSelected:(BlocData*)blocSelected
{
    [_pTowerLayer menuSendOneBloc:blocSelected];
}

-(void)godIsAngry
{
    [_pTowerLayer destroyBlocWithGodAttack];
}

-(void)godBecameNotAngry
{
    _pTowerLayer.blocNotPlace = false;
}
@end
