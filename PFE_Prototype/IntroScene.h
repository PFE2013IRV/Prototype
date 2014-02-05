//
//  IntroScene.h
//  PFE_Prototype
//
//  Created by Maximilien on 2/5/14.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BalanceScene.h"
#import "ConstructionScene.h"

@interface IntroScene : CCScene {
   
    
}

@property (nonatomic,strong) CCSprite* _pBackground;

@property (nonatomic,strong) CCMenuItem *_pConstructionMenuItem;

@property (nonatomic,strong) CCMenuItem *_pBalanceMenuItem;
@property (nonatomic,strong) CCLabelTTF *_pLabelConstruction;
@property (nonatomic,strong) CCLabelTTF *_pLabelBalance;
@property int _width,_height;

// init
-(id)init;
-(void) launchConstruction;
-(void) launchBalance;


@end
