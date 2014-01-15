//
//  BalanceTowerLayer.m
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 27/12/2013.
//  Copyright 2013 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "BalanceTowerLayer.h"
#import "BlocData.h"
#import "BlocManager.h"

@implementation BalanceTowerLayer

@synthesize towerData = _towerData;
@synthesize aBlocsTowerSprite = _aBlocsTowerSprite;

-(id) initWithTowerData : (TowerData*) i_pTowerData
{
    if (self = [super init])
    {
        _towerData = i_pTowerData;
        _aBlocsTowerSprite = [[[NSMutableArray alloc] init] autorelease];
        
        [self drawAllBlocsOfTower];
    }
    
    return self;
}


-(void)drawAllBlocsOfTower
{
    int x = 400;
    int y = 200;
    
    for (BlocData *bloc in _towerData._aBlocs)
    {
        CCSprite *pBlocSprite = [BlocManager GetSpriteFromModel:bloc];
        
        y += bloc._scaledSize.height / 2;
        
        int gravityCenterOfBloc = bloc._scaledSize.width / 2 - bloc._gravityCenter.y;
        
        pBlocSprite.position = CGPointMake(x + gravityCenterOfBloc, y);
        
        y += bloc._scaledSize.height / 2;
        
        [_aBlocsTowerSprite addObject:pBlocSprite];
        [self addChild:pBlocSprite];
    }
}


@end
