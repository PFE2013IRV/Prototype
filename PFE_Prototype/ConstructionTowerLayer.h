//
//  ConstructionTowerLayer.h
//  PFE_Prototype
//
//  Created by Thibault Varacca on 16/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TowerLayer.h"
#import "BlocData.h"

@interface ConstructionTowerLayer : TowerLayer

@property (nonatomic, strong) BlocData *pMovingBlocData;
@property (nonatomic, assign) BOOL blocNotPlace;
//bool pour savoir si on a appuyé sur le cube dans le touch begang
@property (nonatomic, assign) BOOL isTouch;

@property (nonatomic, assign) int HeightTower;
@property (nonatomic, assign) int centerWidthTower;
@property (nonatomic, assign) CGRect towerMagnetization;

@property (nonatomic, strong) CCSprite *pMovingSprite;
@property (nonatomic, strong) NSMutableArray *aFallingBloc;

-(id) initWithTowerData:(TowerData*) i_pTowerData;
-(void)menuSendOneBloc:(BlocData*)blocSelected;
@end
