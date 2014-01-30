//
//  GameData.h
//
//
//  This class provides the in-game data. This includes the tower's geometry,
//  the current god and the next one's to come, the time data, the level's goal,
//  the risk calculation...
//


#import <Foundation/Foundation.h>
#import "TowerData.h"
#import "GodData.h"
#import "WindGodData.h"
#import "GlobalConfig.h"

@interface GameData : NSObject{
    
    int _currentGodIndex;
}

// An init method that takes the mandatory information for a game data
// i_eGameSceneMode : the current game scene mode. Legal values are defined in GameSceneMode enum.
// i_pTowerData : the tower data
// i_aGodData : an array of GodData. The size of this array is fixed, depending on the level design.
// retun value : self
-(id) initGameData : (GameSceneMode) i_eGameSceneMode withTowerData: (TowerData*) i_pTowerData
           withGods: (NSArray*) i_aGodData;

// Basic init is re-implemented with NSException to be avoided
-(id) init;

// This function gives the god data of the current god
// retuen value : the god data of the current god in-game
-(GodData*) getCurrentGod;

// The current game scene mode
@property (nonatomic,assign) GameSceneMode _eGameSceneMode;

// The current state of the tower.
@property (nonatomic,strong) TowerData* _pTowerData;

// The data for the elementary gods.
// Size can go from 1 to 3 depending on the level and the gods included by the game designer.
@property (nonatomic,strong) NSArray* _aGodData;

// The data for the wind god. 
@property (nonatomic,strong) WindGodData* _pWindGodData;

//hauteur de la tour pour gagner la partie
@property (nonatomic, assign) int winHeight;




@end
