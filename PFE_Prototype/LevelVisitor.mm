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
#import "BlocBagData.h"
#import "ConstructionScene.h"
#import "BalanceScene.h"

@implementation LevelVisitor

@synthesize _pCurrentGameData;

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
    GodData* pFireGod = [[GodData alloc] initGod:GOD_TYPE_FIRE withDefaultRespect:GOD_RESPECT_DEFAULT withAngerFlag:NO withActiveFlag:YES];
    NSArray* aGods = [[NSArray alloc] initWithObjects:pFireGod, nil];
    
    // La tour, vide puisque c'est le début du niveau.
    TowerData* pTower = [[TowerData alloc] init];
    
     _pCurrentGameData = pGameData = [[GameData alloc] initGameData:SCENE_MODE_CONSTRUCTION withTowerData:pTower withGods:aGods];
    
    NSLog(@"End start level");
    
    return _pCurrentGameData;
}

-(void) changeSceneFromBalanceToConstructionWithId : (int) _iLevelId TowerData : (TowerData*) _iTowerData
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[[ConstructionScene alloc] initGameScene:[self StartLevelConstructionWithId: _iLevelId TowerData:_iTowerData]] autorelease]]];
}
-(void) changeSceneFromConstructionToBalanceWithId : (int) _iLevelId TowerData : (TowerData*) _iTowerData
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[[BalanceScene alloc] initGameScene:[self StartLevelBalanceWithId:_iLevelId TowerData:_iTowerData]] autorelease]]];
    
}
-(GameData*) StartLevelConstructionWithId : (int)_levelId TowerData : (TowerData*) _iTowerData
{
      GameData* pGameData = nil;
    // Les dieux (un seul, le dieu du feu)
    GodData* pFireGod = [[[GodData alloc] initGod:GOD_TYPE_FIRE withDefaultRespect:0 withAngerFlag:NO withActiveFlag:YES] autorelease];
    NSArray* aGods = [[NSArray alloc] initWithObjects:pFireGod, nil];
    
 _pCurrentGameData = pGameData = [[[GameData alloc] initGameData:SCENE_MODE_CONSTRUCTION withTowerData:_iTowerData withGods:aGods] autorelease];
    
    return _pCurrentGameData;

    
}
-(GameData*) StartLevelBalanceWithId : (int) _levelId TowerData : (TowerData*) _iTowerData
{
    
    GameData* pGameData = nil;
    GodData* pFireGod = [[[GodData alloc] initGod:GOD_TYPE_FIRE withDefaultRespect:0 withAngerFlag:NO withActiveFlag:YES] autorelease];
    NSArray* aGods = [[[NSArray alloc] initWithObjects:pFireGod, nil] autorelease];
    
  
    
    _pCurrentGameData = pGameData = [[[GameData alloc] initGameData:SCENE_MODE_BALANCE withTowerData:_iTowerData withGods:aGods] autorelease];
    
    return _pCurrentGameData;
}

-(GameData*) StartLevelBalance : (int) _levelId
{
    NSLog(@"Begin start level Balance");
    
    GameData* pGameData = nil;
    
    // Parse JSON file and get the info
    // ........
    
    // Note : comme on ne fait pas de liste de niveaux en JSON mais
    // juste un prototype avec un niveau fixé, nous allons hardcoder le
    // chargement ici.
    
    // Les dieux (un seul, le dieu du feu)
    GodData* pFireGod = [[[GodData alloc] initGod:GOD_TYPE_FIRE withDefaultRespect:0 withAngerFlag:NO withActiveFlag:YES] autorelease];
    NSArray* aGods = [[[NSArray alloc] initWithObjects:pFireGod, nil] autorelease];
    
    // La tour, vide puisque c'est le début du niveau.
    TowerData* pTower = [[[TowerData alloc] init] autorelease];
    
    BlocBagData *pBagData = [BlocBagData GetBlocBagData];
    
    //***** creation d'une tour avec 3 carrés, 1 triangle et un autre carré **********//
    [pTower._aBlocs addObject:[pBagData._aBlocs objectAtIndex:0]];
    [pTower._aBlocs addObject:[pBagData._aBlocs objectAtIndex:0]];
    [pTower._aBlocs addObject:[pBagData._aBlocs objectAtIndex:0]];
    [pTower._aBlocs addObject:[pBagData._aBlocs objectAtIndex:1]];
    [pTower._aBlocs addObject:[pBagData._aBlocs objectAtIndex:2]];
    
    //***** creation d'une tour avec 2 carrés, 2 triangle et un autre carré **********//
    /*[pTower._aBlocs addObject:[pBagData._aBlocs objectAtIndex:0]];
    [pTower._aBlocs addObject:[pBagData._aBlocs objectAtIndex:0]];
    [pTower._aBlocs addObject:[pBagData._aBlocs objectAtIndex:1]];
    [pTower._aBlocs addObject:[pBagData._aBlocs objectAtIndex:1]];
    [pTower._aBlocs addObject:[pBagData._aBlocs objectAtIndex:0]];*/
    
    _pCurrentGameData = pGameData = [[[GameData alloc] initGameData:SCENE_MODE_BALANCE withTowerData:pTower withGods:aGods] autorelease];
    
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
        // car son init fait appel à des fonctions run time.
    }
    
    return self;
}

@end
