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
@synthesize _pHUDRespect;
@synthesize _pHUDBackgrounds;
@synthesize _pHUDFrames;


-(id) init
{
    if(self = [super init])
    {
        
        _pHUDBackgrounds = [CCSprite spriteWithFile:@"HUD_backgrounds.png"];
        _pHUDRespect = [CCSprite spriteWithFile:@"HUD_respectGreen.png"];
        _pHUDFrames = [CCSprite spriteWithFile:@"HUD_frames.png"];
        
        _pHUDBackgrounds.anchorPoint = ccp(0.0f,0.0f);
        _pHUDBackgrounds.position = ccp(0.0f,574.0f);
        
        _pHUDRespect.anchorPoint = ccp(0.0f,0.0f);
        _pHUDRespect.position = ccp(0.0f,584.0f);
        
        _pHUDFrames.anchorPoint = ccp(0.0f,0.0f);
        _pHUDFrames.position = ccp(0.0f,574.0f);
        
        [self addChild:_pHUDBackgrounds];
        [self addChild:_pHUDRespect];
        [self addChild:_pHUDFrames];
        
        _pCurrentGameData = [LevelVisitor GetLevelVisitor]._pCurrentGameData;
        
        if(_pCurrentGameData._eGameSceneMode == SCENE_MODE_CONSTRUCTION)
           [self schedule:@selector(decreaseRespect:) interval:0.5];
        

    }
    
    return self;
    
    
}

-(void) decreaseRespect: (ccTime) dt
{
    GodData* pCurrGod = [_pCurrentGameData getCurrentGod];
    
    
    if(pCurrGod._respect >= 0)
    {
        pCurrGod._respect -= 1;
        
        if(pCurrGod._isAngry == YES)
        {
            pCurrGod._respect -= 1.1;
            if(pCurrGod < 0)
                pCurrGod._respect = 0;
        }
    }
    
    
    /*if(pCurrGod._isAngry == NO)
    {
        [_pCurrentGameData getCurrentGod]._respect -= 1;
        
    }*/
    
    if(pCurrGod._isAngry == YES)
    {
        
        CGPoint pos = _pHUDRespect.position;
        [_pHUDRespect removeFromParent];
        _pHUDRespect = [CCSprite spriteWithFile:@"HUD_respectRed.png"];
        _pHUDRespect.anchorPoint = ccp(0.0f,0.0f);
        _pHUDRespect.position = pos;
        
        
        
        [self addChild:_pHUDRespect];
        [self reorderChild:_pHUDFrames z:[self children].count - 1];
        
        
    }
    else if(pCurrGod._isAngry == NO && [_pCurrentGameData getCurrentGod]._respect > GOD_ANGER_LIMIT && [_pCurrentGameData getCurrentGod]._respect < GOD_WARNING_LIMIT)
    {
        CGPoint pos = _pHUDRespect.position;
        [_pHUDRespect removeFromParent];
        _pHUDRespect = [CCSprite spriteWithFile:@"HUD_respectOrange.png"];
        _pHUDRespect.anchorPoint = ccp(0.0f,0.0f);
        _pHUDRespect.position = pos;
        
        
        [self addChild:_pHUDRespect];
        [self reorderChild:_pHUDFrames z:[self children].count - 1];
        
    }
    else if(pCurrGod._isAngry == NO && [_pCurrentGameData getCurrentGod]._respect > GOD_ANGER_LIMIT && [_pCurrentGameData getCurrentGod]._respect > GOD_WARNING_LIMIT)
    {
        CGPoint pos = _pHUDRespect.position;
        [_pHUDRespect removeFromParent];
        _pHUDRespect = [CCSprite spriteWithFile:@"HUD_respectGreen.png"];
        _pHUDRespect.anchorPoint = ccp(0.0f,0.0f);
        _pHUDRespect.position = pos;
        
        
        [self addChild:_pHUDRespect];
        [self reorderChild:_pHUDFrames z:[self children].count - 1];
        
    }
    
    float RespectLength = [_pHUDRespect boundingBox].size.width;
    RespectLength = -RespectLength+(pCurrGod._respect * RespectLength  / GOD_RESPECT_DEFAULT);
    
    CCAction* pMove = [CCMoveTo actionWithDuration:0.5f position:ccp(RespectLength,_pHUDRespect.position.y)];
    [_pHUDRespect runAction:pMove];
    
    
}

@end
