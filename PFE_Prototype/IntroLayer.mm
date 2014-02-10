//
//  IntroLayer.m
//  PFE_Prototype
//
//  Created by Karim Le Nir Aboul-Enein on 20/12/2013.
//  Copyright Karim Le Nir Aboul-Enein 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "IntroScene.h"
#import "HelloWorldLayer.h"
#import "BlocManager.h"
#import "BlocBagData.h"
#import "LevelVisitor.h"

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
		
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            CCSprite *background;
            
            background = [CCSprite spriteWithFile:@"Default.png"];
            
            background.position = ccp(size.width/2, size.height/2);
            
            // add the label as a child to this Layer
            [self addChild: background];

        }
        
        /////////////////////////////////////////////////////////////////////////////////
        // Karim : tests sur la création de blocs PNG. Ne pas toucher à ce code :)    ///
        
        BlocBagData* pBlocBagData = [BlocBagData GetBlocBagData];
        
        BlocData* pBloc = [pBlocBagData._aBlocs objectAtIndex:0];
        
        CCSprite* pSpriteBloc = [BlocManager GetSpriteFromModel:pBloc];
        pSpriteBloc.position = ccp(0.0f,0.0f);
        pSpriteBloc.anchorPoint = ccp(0.0f,0.0f);
        
        [self addChild:pSpriteBloc];
        
      //  BlocManager* pBlocManagerInstance = [BlocManager GetBlocManager];
        
        //[pBlocManagerInstance DeletePNGFiles];
        
        
        /////////////////////////////////////////////////////////////////////////////////
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.0 scene:[[[IntroScene alloc] init] autorelease]]];
}

@end
