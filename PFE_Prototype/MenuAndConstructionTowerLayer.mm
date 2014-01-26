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

-(id) initWithTowerData : (TowerData*) i_pTowerData
{
    if (self = [super init])
    {
        _pMenuLayer = [MenuLayer node];
        _pTowerLayer = [[[ConstructionTowerLayer alloc] initWithTowerData:i_pTowerData] autorelease];
        
        _pMenuLayer.delegate = self;
        
        [self addChild:_pMenuLayer];
        [self addChild:_pTowerLayer];
    }
    
    return self;
}

-(void)BlocHasBeenSelected:(BlocData*)blocSelected
{
    [_pTowerLayer menuSendOneBloc:blocSelected];
}

@end
