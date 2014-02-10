//
//  BalanceScene.h
//
//  The tower balance game scene
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"
#import "GameSceneProtocol.h"
#import "ConstructionScene.h"
#import "TowerAndPlanetLayer.h"
@interface BalanceScene : GameScene <GameSceneProtocol>


@property (nonatomic, strong) ConstructionScene *previusScene;
@property (nonatomic,strong) TowerAndPlanetLayer* _pTowerAndPlanetLayer;
@property (nonatomic, strong) PlanetLayer *pPlanetLayer;;
// Game scene init with game data is requiered for every game scene.
// i_pGameData : the game data used to initialize the scene
// return value : self
-(id) initGameScene : (GameData*) i_pGameData CurrentBackground :(CCSprite*) i_CurrentBackground CurrenPlanet : (PlanetLayer*) planet; //CurrentSun  : (ccColor4B) i_CurrentSunColor;



// Basic init is re-implemented with NSException to be avoided
// return value : nil
-(id) init;

@end
