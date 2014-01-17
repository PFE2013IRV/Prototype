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

-(id) initWithTowerData : (TowerData*) i_pTowerData
{
    if (self = [super init])
    {
        self._pTowerData = i_pTowerData;
        self._aBlocsTowerSprite = [[NSMutableArray alloc] init];
        
        [self drawAllBlocsOfTower];
    }
    
    return self;
}


-(void)drawAllBlocsOfTower
{
    int x = 400;
    int y = 200;
    
    for (BlocData *bloc in self._pTowerData._aBlocs)
    {
        CCSprite *pBlocSprite = [BlocManager GetSpriteFromModel:bloc];
        
        y += bloc._scaledSize.height / 2;
        
        int gravityCenterOfBloc = bloc._scaledSize.width / 2 - bloc._gravityCenter.x;
        
        pBlocSprite.position = CGPointMake(x + gravityCenterOfBloc, y);
        
        y += bloc._scaledSize.height / 2;
        
        [self._aBlocsTowerSprite addObject:pBlocSprite];
        [self addChild:pBlocSprite];
    }
}

@end
