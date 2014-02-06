//
//  TowerLayer.h
//
//  The layer that contains the tower. It is based on a TowerData.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"

@interface TowerLayer : CCLayer {
    
}

// The TowerData that contains all the layer's information
@property(nonatomic,strong) TowerData* _pTowerData;
//Al ccSprite of the Tower
@property (nonatomic, strong) NSMutableArray *_aBlocsTowerSprite;
// The current game data
@property (nonatomic, strong) GameData* _pCurrentGameData;

-(id) init;

@end
