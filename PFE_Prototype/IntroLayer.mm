//
//  IntroLayer.m
//  PFE_Prototype
//
//  Created by Karim Le Nir Aboul-Enein on 20/12/2013.
//  Copyright Karim Le Nir Aboul-Enein 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "BalanceScene.h"
#import "ConstructionScene.h"
#import "HelloWorldLayer.h"
#import "BlocManager.h"
#import "BlocBagData.h"

#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//
-(id) init
{
	if( (self=[super init])) {
		
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);
		
		// add the label as a child to this Layer
		[self addChild: background];
        
        
        /////////////////////////////////////////////////////////////////////////////////
        // Karim : tests sur la création de blocs PNG. Ne pas toucher à ce code :)    ///
        
        BlocManager* pBlocManagerInstance = [BlocManager GetBlocManager];
        BlocBagData* pBlocBagData = [BlocBagData GetBlocBagData];
        
        [pBlocManagerInstance LoadBlocsToBlocBag];
        [pBlocManagerInstance DeletePNGFiles];
        
        BlocData* pBloc = [pBlocBagData._aBlocs objectAtIndex:0];
        
        CCSprite* pSpriteBloc = [pBlocManagerInstance GetSpriteFromModel:pBloc];
        pSpriteBloc.position = ccp(0.0f,0.0f);
        pSpriteBloc.anchorPoint = ccp(0.0f,0.0f);
        
        [self addChild:pSpriteBloc];
        /////////////////////////////////////////////////////////////////////////////////
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
    
    
    //Code pour Alex et Yann : Equilibre
//    GameData *pGameData = [[GameData alloc] initGameData:SCENE_MODE_BALANCE withTowerData:nil withGods:nil];
//	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[[BalanceScene alloc] initGameScene:pGameData] autorelease]]];
   
    //Code pour Max et Thibault : Construction
    
    GameData *pGameData = [[GameData alloc] initGameData:SCENE_MODE_CONSTRUCTION withTowerData:nil withGods:nil];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[[ConstructionScene alloc] initGameScene:pGameData] autorelease]]];
}
@end
