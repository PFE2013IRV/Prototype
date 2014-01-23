//
//  BalanceTowerLayer.m
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 27/12/2013.
//  Copyright 2013 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "BalanceTowerLayer.h"
#import "BlocData.h"
#import "BlocManager.h"
// Not included in "cocos2d.h"
#import "CCPhysicsSprite.h"

enum {
	kTagParentNode = 1,
};


@implementation BalanceTowerLayer

-(id) initWithTowerData : (TowerData*) i_pTowerData
{
    if (self = [super init])
    {
        self._pTowerData = i_pTowerData;
        self._aBlocsTowerSprite = [[NSMutableArray alloc] init];
        CGSize s = [CCDirector sharedDirector].winSize;
        
        // init physics
		[self initPhysics];
        //[self drawAllBlocsOfTower];
        
		// Use batch node. Faster
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"blocks.png" capacity:100];
		spriteTexture_ = [parent texture];

		[self addChild:parent z:0 tag:kTagParentNode];
		
		
		[self addNewSpriteAtPosition:ccp(10, s.height/2)];
        int x = 400;
        int y = 200;
        for (BlocData *bloc in self._pTowerData._aBlocs)
          {
                y += bloc._scaledSize.height / 2;
        
                int gravityCenterOfBloc = bloc._scaledSize.width / 2 - bloc._gravityCenter.x;
                y += bloc._scaledSize.height / 2;
               // pBlocSprite.position = CGPointMake(x + gravityCenterOfBloc, y);

                [self addNewCircleAtPosition:bloc AtPoint:CGPointMake(x + gravityCenterOfBloc, y)];
        }
        
        // [pBlocSprite setB2Body: [self AddBloc:bloc AtPoint:(CGPointMake(x + gravityCenterOfBloc, y))] ];
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap screen" fontName:@"Marker Felt" fontSize:32];
		[self addChild:label z:0];
		[label setColor:ccc3(0,0,255)];
		label.position = ccp( s.width/2, s.height-50);
		
		[self scheduleUpdate];
	}
    
    return self;
}

-(void) initPhysics
{
	
     CGSize s = [[CCDirector sharedDirector] winSize];
     
     b2Vec2 gravity;
     gravity.Set(0.0f, -1.0f);
     world = new b2World(gravity);
     
     
     // Do we want to let bodies sleep?
     world->SetAllowSleeping(true);
     
     world->SetContinuousPhysics(true);
     
     m_debugDraw = new GLESDebugDraw( PTM_RATIO );
     world->SetDebugDraw(m_debugDraw);
     
     uint32 flags = 0;
     flags += b2Draw::e_shapeBit;
     //		flags += b2Draw::e_jointBit;
     //		flags += b2Draw::e_aabbBit;
     //		flags += b2Draw::e_pairBit;
     //		flags += b2Draw::e_centerOfMassBit;
     m_debugDraw->SetFlags(flags);
     
     
     // Define the ground body.
     b2BodyDef groundBodyDef;
     groundBodyDef.position.Set(0, 0); // bottom-left corner
     
     // Call the body factory which allocates memory for the ground body
     // from a pool and creates the ground box shape (also from a pool).
     // The body is also added to the world.
     b2Body* groundBody = world->CreateBody(&groundBodyDef);
     
     // Define the ground box shape.
     b2EdgeShape groundBox;
     
     // bottom
     
     groundBox.Set(b2Vec2(0,0), b2Vec2(s.width/PTM_RATIO,0));
     groundBody->CreateFixture(&groundBox,0);
     
     // top
     groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO));
     groundBody->CreateFixture(&groundBox,0);
     
     // left
     groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(0,0));
     groundBody->CreateFixture(&groundBox,0);
     
     // right
     groundBox.Set(b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,0));
     groundBody->CreateFixture(&groundBox,0);
}



-(void)drawAllBlocsOfTower
{
    int x = 400;
    int y = 200;
    
    for (BlocData *bloc in self._pTowerData._aBlocs)
    {
        CCSprite *pBlocSprite = [BlocManager GetSpriteFromModel:bloc];
        
        y += bloc._scaledSize.height / 2;
        
        int gravityCenterOfBloc = bloc._scaledSize.width / 2 - bloc._gravityCenter.x;
        
        pBlocSprite.position = CGPointMake(x + gravityCenterOfBloc, y);
        
        y += bloc._scaledSize.height / 2;
        
        [self._aBlocsTowerSprite addObject:pBlocSprite];
        [self addChild:pBlocSprite];
    }
}


-(void) draw
{
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	world->DrawDebugData();
	
	kmGLPopMatrix();
}

-(void) addNewSpriteAtPosition:(CGPoint)p
{
	CCLOG(@"Add sprite %0.2f x %02.f",p.x,p.y);
	// Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	b2Body *body = world->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body.
	b2PolygonShape dynamicBox;
	dynamicBox.SetAsBox(.5f, .5f);//These are mid points for our 1m box
	
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
	body->CreateFixture(&fixtureDef);
	
    
	CCNode *parent = [self getChildByTag:kTagParentNode];
	
	//We have a 64x64 sprite sheet with 4 different 32x32 images.  The following code is
	//just randomly picking one of the images
	int idx = (CCRANDOM_0_1() > .5 ? 0:1);
	int idy = (CCRANDOM_0_1() > .5 ? 0:1);
	CCPhysicsSprite *sprite = [CCPhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(32 * idx,32 * idy,32,32)];
	[parent addChild:sprite];
	
	[sprite setPTMRatio:PTM_RATIO];
	[sprite setB2Body:body];
	[sprite setPosition: ccp( p.x, p.y)];
    
}


-(void) addNewCircleAtPosition:(BlocData*)b AtPoint:(CGPoint)p

{
    std::vector<CGPoint> forme = [b GetPhysicalVertices];
    
    CGPoint pointTmp;
    

    CCLOG(@"Add sprite %0.2f x %02.f",p.x,p.y);
    
    // Define the dynamic body.
    
    //Set up a 1m squared box in the physics world
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    
    bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    
    b2Body *body = world->CreateBody(&bodyDef);
    
    
    // Define another box shape for our dynamic body.
    
    //b2CircleShape dynamicBox;
    
    
    
    //dynamicBox.m_p.Set(0, 0); //position, relative to body position
    
    //dynamicBox.m_radius = 34; //radius
    
    
    b2Vec2 vertices[100];
    

    
    
    CCLOG(@"Call Addbloc");
    
    
    
    for(int i = 0 ; i < forme.size()  ; i++)
        
    {
        
        pointTmp = forme[i];
        
        
        
        vertices[i].Set( (double) pointTmp.x/PTM_RATIO
                        
                        //*'0.0f'
                        
                        ,
                        
                        (double) pointTmp.y/PTM_RATIO
                        
                        //*'0.0f'
                        
                        );
        
        //[[for                           me objectAtIndex:i] CGPointValue];
        
        //forme.push_back(pointTmp);
        
        
        
        CCLOG(@"Add sprite %0.f x %0.f",vertices[i].x,vertices[i].y);
        
        
        
        
        
    }
    
/*
    
    b2Vec2 vertices[5];
    
    vertices[0].Set(-1,  2);
    
    vertices[1].Set(-1,  0);
    
    vertices[2].Set( 0, -3);
    
    vertices[3].Set( 1,  0);
    
    vertices[4].Set( 1,  1);
 */
    
    b2PolygonShape polygonShape;
    
    polygonShape.Set(vertices, forme.size()); //pass array to the shape
    
    // Define the dynamic body fixture.
    
    b2FixtureDef fixtureDef;
    
    fixtureDef.shape = &polygonShape;
    
    fixtureDef.density = 1.0f;
    
    fixtureDef.friction = 0.3f;
    
    body->CreateFixture(&fixtureDef);
    
    
    
    
    CCNode *parent = [self getChildByTag:kTagParentNode];
    
    
    //We have a 64x64 sprite sheet with 4 different 32x32 images.  The following code is
    
    //just randomly picking one of the images
    
    int idx = (CCRANDOM_0_1() > .5 ? 0:1);
    
    int idy = (CCRANDOM_0_1() > .5 ? 0:1);
    
    CCPhysicsSprite *sprite = [CCPhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(32 * idx,32 * idy,32,32)];
    
    [parent addChild:sprite];
    
    
    [sprite setPTMRatio:PTM_RATIO];
    
    [sprite setB2Body:body];
    
    [sprite setPosition: ccp( p.x, p.y)];
    
    
    
}
-(void) update: (ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);
}


@end
