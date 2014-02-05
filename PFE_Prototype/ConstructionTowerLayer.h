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
#import "FireAttackLayer.h"
#import "GameData.h"
#import "GodData.h"
#import "LevelVisitor.h"
#import "ParticleFire.h"
//#import "ConstructionScene.h"

@protocol ConstructionTowerDelegate <NSObject>

@required
-(void)movePlanet:(int)height;

@end // end of delegate protocol

@interface ConstructionTowerLayer : TowerLayer<FireAttackDelegate>
{
    id <ConstructionTowerDelegate> _delegate;
}

@property (nonatomic, strong) id delegate;

@property (nonatomic, strong) BlocData *pMovingBlocData;
@property (nonatomic, assign) BOOL blocNotPlace;
//bool pour savoir si on a appuyé sur le cube dans le touch begang
@property (nonatomic, assign) BOOL isTouch;

@property (nonatomic, assign) int HeightTower;
@property (nonatomic, assign) int centerWidthTower;
@property (nonatomic, assign) CGRect towerMagnetization;

@property (nonatomic, strong) CCSprite *pMovingSprite;
@property (nonatomic, strong) NSMutableArray *aFallingBloc;

@property (nonatomic, assign) int winningHeight;
@property (nonatomic, assign) int currentHeightNoScroll;

@property(nonatomic, strong) GameData* _currentGameData;
@property(nonatomic, strong) GodData* _currentGodData;

@property(nonatomic, strong) NSMutableArray* _aParticlesArray;


-(id) initWithTowerData:(TowerData*) i_pTowerData WinningHeight:(int)winHeight;
-(void)menuSendOneBloc:(BlocData*)blocSelected;
- (void) movingSpriteFalling : (id) sender;
- (void) removeMovingSpriteFromParent : (id) sender;

@end
