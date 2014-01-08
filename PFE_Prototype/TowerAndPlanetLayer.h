//
//  TowerAndPlanetLayer.h
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 27/12/2013.
//  Copyright 2013 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BalanceTowerLayer.h"
#import "PlanetLayer.h"
#import "GameData.h"

@interface TowerAndPlanetLayer : CCLayer <PlanetDelegate> {
    
}

@property (nonatomic, strong) BalanceTowerLayer *balanceTower;
@property (nonatomic, strong) PlanetLayer *planet;

-(id) initWithGameData : (GameData*) i_pGameData PlanetLayer: (PlanetLayer*) i_pPlanet;

@end
