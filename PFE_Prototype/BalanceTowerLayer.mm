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
        
        // init physics
		[self initPhysics];
        [self drawAllPhysicsBlocsOfTower];
       	[self scheduleUpdate];
    }
    return self;
}

-(void) initPhysics
{
	
     CGSize s = [[CCDirector sharedDirector] winSize];
     
     b2Vec2 gravity;
     gravity.Set(0.0f, -20.0f);
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
     groundBodyDef.position.Set(0, (
                                    
                                    s.height/6
                                    )/PTM_RATIO); // bottom-left corner
    
     // Call the body factory which allocates memory for the ground body
     // from a pool and creates the ground box shape (also from a pool).
     // The body is also added to the world.
     groundBody = world->CreateBody(&groundBodyDef);
    groundBody->SetFixedRotation(false);
     
     // Define the ground box shape.
     b2EdgeShape groundBox;
     
     // bottom
     
     groundBox.Set(b2Vec2(0,0), b2Vec2(s.width/PTM_RATIO,0));
     groundBody->CreateFixture(&groundBox,0);
     
     // top
     groundBox.Set(b2Vec2(0,s.height /PTM_RATIO ), b2Vec2(s.width/PTM_RATIO,s.height /PTM_RATIO));
     groundBody->CreateFixture(&groundBox,0);
     
     // left
     groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(0,0));
     groundBody->CreateFixture(&groundBox,0);
     
     // right
     groundBox.Set(b2Vec2(s.width/PTM_RATIO,s.height /PTM_RATIO), b2Vec2(s.width/PTM_RATIO,0));
     groundBody->CreateFixture(&groundBox,0);
}



-(void)drawAllPhysicsBlocsOfTower
{
    int x = 350;
    int y = 100;
    
    for (BlocData *bloc in self._pTowerData._aBlocs)
    {
        CCPhysicsSprite *pBlocSprite = [BlocManager GetPhysicsSpriteFromModel:bloc];
        pBlocSprite.anchorPoint = ccp(0.0f,0.0f);
        
        y += bloc._scaledSize.height / 2;
        
        int gravityCenterOfBloc = bloc._scaledSize.width / 2 - bloc._gravityCenter.x;
        
        [self._aBlocsTowerSprite addObject:pBlocSprite];
        [self addChild:pBlocSprite];
        
        [self createBodyForPhysicSprite:pBlocSprite BlocData:bloc Point:CGPointMake(x -100, y-100)];
        
       
        CCLOG(@"Add sprite %0.2f x %02.f",(double)x + gravityCenterOfBloc,(double)y);

        [pBlocSprite setPosition:CGPointMake(x + gravityCenterOfBloc, y)];
        y += bloc._scaledSize.height / 2;
    }

}



-(void)createBodyForPhysicSprite:(CCPhysicsSprite*)sprite BlocData:(BlocData*)b Point:(CGPoint)p
{
    std::vector<CGPoint> forme = [b GetPhysicalVertices];
    CGPoint pointTmp;
    
    CCLOG(@"Add body %0.2f x %02.f",p.x,p.y);
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(p.x-50/PTM_RATIO, p.y-50/PTM_RATIO);
    //bodyDef.userData = sprite;
   
    b2Body *body = world->CreateBody(&bodyDef);
    
    b2Vec2 vertices[100];
    
  //  CCLOG(@"Call Addbloc");
    for(int i = forme.size() ; i >= 0  ; i--)
    {
        pointTmp = forme[i];
        vertices[i].Set( (double) pointTmp.x/PTM_RATIO,(double) pointTmp.y/PTM_RATIO);
   //     CCLOG(@"Add sprite %0.f x %0.f",vertices[i].x,vertices[i].y);
    }
    
    b2PolygonShape polygonShape;
    polygonShape.Set(vertices, forme.size()); //pass array to the shape
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &polygonShape;
    fixtureDef.density = 1000.0f;
    fixtureDef.friction = 1000;//0.3f;
    //fixtureDef.isSensor = true;
    
    fixtureDef.restitution = 0;
    body->CreateFixture(&fixtureDef);
        
    [sprite setPTMRatio:PTM_RATIO];
    [sprite setB2Body:body];
    //[sprite setPosition: ccp( p.x, p.y)];
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

-(void) rotateGroundWorld:(int)degree
{
 
    
    int i = 1;
    int j =1;
    for(b2Body *b = world->GetBodyList(); b; b=b->GetNext())
    {
       // if (b != groundBody)
        {
           
            
            if(i==5)
            {
                
                b->SetLinearVelocity(b2Vec2(0,0));
                b->SetAngularVelocity(0);
              //  b2Vec2  b2Position = b->GetPosition();
            
               
                 //CCPhysicsSprite *sprite = (CCPhysicsSprite *)b->GetUserData();
                 
              // b->ApplyForce( b->GetMass() * - world->GetGravity(), b->GetWorldCenter() );
                // float32 b2Angle = -1 * CC_DEGREES_TO_RADIANS(sprite.rotation);
                // b->setGravityScale(0);
               //  b->SetTransform(b->GetPosition(), CC_DEGREES_TO_RADIANS(degree));
                 //b2Vec2 pos = b->GetPosition();
                 //   b->ApplyTorque(degree);
                 //    b->Get
                 //b->ApplyForce( b2Vec2(10,0), b->GetWorldPoint( b2Vec2(1,1) ) );
                 // b->SetAngularVelocity(degree);
                 // b->SetTransform(pos, CC_DEGREES_TO_RADIANS(degree));
                
            }
            else
                b->SetTransform(b->GetPosition(), CC_DEGREES_TO_RADIANS(degree *0.5));

            i++;
        }
    }
    /*
     // CGSize s = [[CCDirector sharedDirector] winSize];
     groundBody->SetTransform(
     
     
     
     //b2Vec2(1,1)
     //b2Vec2(s.width/2/PTM_RATIO,s.height/2/PTM_RATIO)
     groundBody->GetWorldCenter()
     , CC_DEGREES_TO_RADIANS(degree));
    
*/

}

@end
