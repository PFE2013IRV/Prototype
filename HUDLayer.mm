//
//  HUDLayer.m
//  PFE_Prototype
//
//  Created by Yann Thebault on 05/02/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "HUDLayer.h"
#import "LevelVisitor.h"
#import "GlobalConfig.h"

@implementation HUDLayer

@synthesize _pCurrentGameData;


-(id) init
{
    if(self = [super init])
    {
        
        _pCurrentGameData = [LevelVisitor GetLevelVisitor]._pCurrentGameData;
        
        if(_pCurrentGameData._eGameSceneMode == SCENE_MODE_CONSTRUCTION)
           [self schedule:@selector(decreaseRespect:) interval:1];
    }
    
    return self;
    
    
}

-(void) decreaseRespect: (ccTime) dt
{
    GodData* pCurrGod = [_pCurrentGameData getCurrentGod];
    
    if(pCurrGod._isAngry == NO)
        [_pCurrentGameData getCurrentGod]._respect -= 2;
    
}

@end
