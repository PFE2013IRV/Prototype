//
//  HUDLayer.h
//  PFE_Prototype
//
//  Created by Yann Thebault on 05/02/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"


@interface HUDLayer : CCLayer {
    
    float _sunTimerRuntime;
    
}

@property (nonatomic,strong) GameData* _pCurrentGameData;

// Construction HUD
@property (nonatomic,strong) CCSprite* _pHUDRespect;
@property (nonatomic,strong) CCSprite* _pHUDBackgrounds;
@property (nonatomic,strong) CCSprite* _pHUDFrames;
@property (nonatomic,strong) CCSprite* _pHUDSunTimer;
@property (nonatomic,strong) CCSprite* _pHUDSunFrame;

// Balance HUD


@end
