//
//  LevelVisitor.h
//
//
//  Singleton.
//  This class can manage the data relative to levels (load the level list from a JSON save file,
//  unlock new levels...). When a level is launched, it also generates the GameData according
//  to the specificities of the level.
//
//


#import <Foundation/Foundation.h>
#import "GameData.h"
#import "cocos2d.h"


@interface LevelVisitor : NSObject


// Static accessor to the single instance of the LevelVisitor
// return value : a singleton LevelVisitor object
+(LevelVisitor*) GetLevelVisitor;

// Generates a game data for a specific level. Given a level identifier,
// this method loads the specificities of the level and fills a GameData
// object. This should be called during the loading phase of a level.
// _levelId : the integer id of the level used to reach the information in the save file
// return value : the GameData at the beginning of the level
-(GameData*) StartLevel : (int) _levelId;

// Generates a game data for a specific level. Given a level identifier,
// this method loads the specificities of the level and fills a GameData
// object. This should be called during the loading phase of a level.
// _levelId : the integer id of the level used to reach the information in the save file
// return value : the GameData for Balance scene
-(GameData*) StartLevelBalance : (int) _levelId;

//Manage the transition between scene Balance and Construction , keeping the tower data as is.
-(GameData*) StartLevelBalanceWithId : (int) _levelId TowerData : (TowerData*) _iTowerData;

//Manage the transition between scene Construction and Balance , keeping the tower data as is.
-(GameData*) StartLevelConstructionWithId : (int)_levelId TowerData : (TowerData*) _iTowerData;
// This property holds the current game data and can be accessed and changed at any time
@property (nonatomic,strong) GameData* _pCurrentGameData;


@end
