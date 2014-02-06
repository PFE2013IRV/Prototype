//
//  IntroScene.m
//  PFE_Prototype
//
//  Created by Maximilien on 2/5/14.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "IntroScene.h"


@implementation IntroScene

@synthesize _pBackground;
@synthesize _pConstructionMenuItem,_pBalanceMenuItem;
@synthesize _pLabelConstruction,_pLabelBalance;
@synthesize _height,_width;

-(id)init
{
    if (self = [super init])
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        _width = size.width;
        _height = size.height;
        
        _pBackground = [CCSprite spriteWithFile:@"Default.png"];
        _pBackground.position = ccp(_width/2,_height/2);
        
        
        _pLabelConstruction = [[CCLabelTTF labelWithString:@"Mode Construction"
                                   dimensions:CGSizeMake(320, 50) alignment:kCCTextAlignmentCenter
                                     fontName:@"Arial" fontSize:32.0] retain];
        
        _pLabelBalance = [[CCLabelTTF labelWithString:@"Mode Équilibre"
                                                dimensions:CGSizeMake(320, 50) alignment:kCCTextAlignmentCenter
                                                  fontName:@"Arial" fontSize:32.0] retain];
        
        
        
        //A changer en CCMenuItemImage pour un plus beau menu . Demander à karim de faire des peites images pour l'intro menu
        _pConstructionMenuItem = [CCMenuItemLabel itemWithLabel:_pLabelConstruction target:self selector:@selector(launchConstruction)];
        _pConstructionMenuItem.position = ccp(0, 130);
        
        _pBalanceMenuItem = [CCMenuItemLabel itemWithLabel:_pLabelBalance target:self selector:@selector(launchBalance)];
        _pBalanceMenuItem.position = ccp(0, -130);
        
        CCMenu *menuIntro = [CCMenu menuWithItems:_pConstructionMenuItem,_pBalanceMenuItem, nil];
        menuIntro.position = ccp(_width/2,_height/2);
        [self addChild:_pBackground];
        [self addChild:menuIntro];
        
        
    }
    return self;
}

-(void) launchConstruction
{
    [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInR transitionWithDuration:1.0 scene:[[[ConstructionScene alloc] initGameScene:[[LevelVisitor GetLevelVisitor] StartLevel:0]] autorelease]]];
}
-(void) launchBalance
{
    [[CCDirector sharedDirector] pushScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[[BalanceScene alloc] initGameScene:[[LevelVisitor GetLevelVisitor] StartLevelBalance:0]CurrentBackground:nil CurrentSun:ccc4(0, 0, 0, 0)] autorelease]]];
}

@end
