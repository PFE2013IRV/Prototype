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
           [self schedule:@selector(decreaseRespect:) interval:1.0];
    }
    
    return self;
    
    
}

-(void) decreaseRespect: (ccTime) dt
{
    
    _pCurrentGameData._godRespect -= 2;
    
}

@end
