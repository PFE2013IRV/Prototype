//
//  BalanceTowerLayer.h
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 27/12/2013.
//  Copyright 2013 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TowerLayer.h"
#import "TowerData.h"

@interface BalanceTowerLayer : TowerLayer {
    
}

@property (nonatomic, strong) TowerData* towerData;
@property (nonatomic, strong) NSMutableArray *aBlocsTowerSprite;

-(id) initWithTowerData : (TowerData*) i_pTowerData;

@end
