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



@end
