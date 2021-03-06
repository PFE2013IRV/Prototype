//
//  MenuAndConstructionTowerLayer.h
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 17/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuLayer.h"
#import "ConstructionTowerLayer.h"
#import "TowerData.h"
#import "PlanetLayer.h"
#import "FireAttackLayer.h"

@interface MenuAndConstructionTowerLayer : CCLayer <MenuDelegate>


@property (nonatomic, strong) MenuLayer *pMenuLayer;
@property (nonatomic, strong) ConstructionTowerLayer *pTowerLayer;

-(id) initWithTowerData : (TowerData*) i_pTowerData HeightWin:(int)win;

-(void)godIsAngry;
-(void)godBecameNotAngry;

@end
