//
//  ConstructionScene.h
//
//  The construction game scene
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"
#import "GameSceneProtocol.h"
#import "MenuAndConstructionTowerLayer.h"
#import "GodWrathLayer.h"
@interface ConstructionScene : GameScene <GameSceneProtocol>

// Game scene init with game data is requiered for every game scene.
// i_pGameData : the game data used to initialize the scene
// return value : self
-(id) initGameScene : (GameData*) i_pGameData;


// Basic init is re-implemented with NSException to be avoided
// return value : nil
-(id) init;

@property (nonatomic, strong) FireAttackLayer* _pFireAttackLayer;

@property (nonatomic, strong) WindAttackLayer* _pWindAttackLayer;

@property (nonatomic, strong) ElementGodsLayer* _pElementGodsLayer;

@property (nonatomic, strong) MenuAndConstructionTowerLayer *pMenuAndTowerLayer;

@property (nonatomic,strong) GodWrathLayer *_pGodWrathLayer;

@end
