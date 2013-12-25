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

#import "LevelVisitor.h"
#import "GodData.h"
#import "TowerData.h"
#import "GlobalConfig.h"

@implementation LevelVisitor

// Instance variable for the level visitor
static LevelVisitor* pLevelVisitor = nil;

-(GameData*) StartLevel : (int) _levelId
{
    NSLog(@"Begin start level");
    
    GameData* pGameData = nil;
    
    // Parse JSON file and get the info
    // ........

    // Note : comme on ne fait pas de liste de niveaux en JSON mais
    // juste un prototype avec un niveau fixé, nous allons hardcoder le
    // chargement ici.
    
    // Les dieux (un seul, le dieu du feu)
    GodData* pFireGod = [[GodData alloc] initGod:GOD_TYPE_FIRE withDefaultRespect:0 withActiveFlag:true];
    NSArray* aGods = [[NSArray alloc] initWithObjects:pFireGod, nil];
    
    // La tour, vide puisque c'est le début du niveau.
    TowerData* pTower = [[TowerData alloc] init];
    
    pGameData = [[[GameData alloc] initGameData:SCENE_MODE_CONSTRUCTION withTowerData:pTower withGods:aGods] autorelease];
    
    NSLog(@"End start level");
    
    return pGameData;
    
}

+(LevelVisitor*) GetLevelVisitor
{
    if(!pLevelVisitor)
    {
        [[self alloc] init];
    }
    
    return pLevelVisitor;
}

+(id) alloc
{
    pLevelVisitor = [super alloc];
    return pLevelVisitor;
}

-(id) init
{
    
    if(self = [super init])
    {
        // Init of the level visitor
    }
    
    return self;
}

@end