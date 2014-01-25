//
//  GodWrathLayer.h
//  PFE_Prototype
//
//  Created by Maximilien on 1/25/14.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"

@interface GodWrathLayer : CCLayer {
    
}
-(id)init;
-(void) skyGodWrath:(ccTime)i_dt;
@property (nonatomic,strong) CCSprite* _pGodWrathAnnimation;
@property (nonatomic,strong) GameData* _pCurrGameData ;
@property (nonatomic,strong) GodData* _pGodData;
@property BOOL _isAnimAngryBeingLaunched;
@property BOOL _isAnimAngryBeingCancelled;
@property  CGFloat _godWrathDisplayHeight,_godWrathDisplayWidth;
@property int _annimationDuration,
_colorRWrath,
_colorGWrath,
_colorBWrath;
@property float _velocityFactor,_incrementAlpha;
@property int _nbAnnimationStep;

@end
