//
//  GameSceneProtocol.h
//
//  This is a protocol that must be adopted by every game scene.
//

#import <Foundation/Foundation.h>
#import "GameData.h"

@protocol GameSceneProtocol

@required

// Game scene init with game data is requiered for every game scene.
// i_pGameData : the game data used to initialize the scene
// return value : self
- (id) initGameScene : (GameData*) i_pGameData;

@end
