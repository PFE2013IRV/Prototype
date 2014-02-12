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

@synthesize pPlanetLayer = _pPlanetLayer;
@synthesize isZooming = _isZooming;
@synthesize scalingFactor = _scalingFactor;
@synthesize positionBeforeZoom = _positionBeforeZoom;
@synthesize zoomOutPosition = _zoomOutPosition;
@synthesize TowerSize;
@synthesize WindAttackType;


-(id) initWithTowerData : (TowerData*) i_pTowerData
{
    if (self = [super init])
    {
        self.TowerSize =0;
        
        self._pTowerData = i_pTowerData;
        
        
        
        
        
        self->RemovedBlocs = [[NSMutableIndexSet alloc] init];
        [self CalculateScalingFactor];
        for (BlocData *bloc in self._pTowerData._aBlocs)
        {
            self.TowerSize+= bloc._scaledSize.height *_scalingFactor;
            // self.TowerSize++;
            CCLOG(@"incrmeent at  %0.2f ", (double) self.TowerSize );
        }
        // init physics
		[self initPhysics];
        
        
        
        
        
        [self drawAllPhysicsBlocsOfTower];
        /*
         id action1 = [CCCallFuncND actionWithTarget:self selector:@selector(ApplyWindAttackLeft:)];
         id action2 = [CCDelayTime actionWithDuration:3];
         id action3 = [CCCallFuncND actionWithTarget:self selector:@selector(ApplyWindAttackRight:)];
         id action4 = [CCDelayTime actionWithDuration:3];
         //[self runAction: [CCSequence actions:action1, action2, action3, action4, nil]];
         */
        // for(int i = 1 ; i <= 2  ; i++)
        //  [self ApplyWindAttackLeft];
        //  [self ApplyWindAttackRight];
        
        [self scheduleUpdate];
        
    }
    
    return self;
}

-(void) initPhysics
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    b2Vec2 gravity;
    gravity.Set(0.0f, -15.0f);
    world = new b2World(gravity);
    
    // Do we want to let bodies sleep?
    world->SetAllowSleeping(true);
    world->SetContinuousPhysics(true);
    
    m_debugDraw = new GLESDebugDraw( PTM_RATIO );
   // world->SetDebugDraw(m_debugDraw);
    
    uint32 flags = 0;
    flags += b2Draw::e_shapeBit;
    //		flags += b2Draw::e_jointBit;
    //		flags += b2Draw::e_aabbBit;
    //		flags += b2Draw::e_pairBit;
    //		flags += b2Draw::e_centerOfMassBit;
    m_debugDraw->SetFlags(flags);
    
    
    // Define the ground body.
    b2BodyDef groundBodyDef;
    
    //CCLOG(@"Scaling at  %0.2f ",(double)(220 * _scalingFactor)/PTM_RATIO);
    
    groundBodyDef.position.Set(0,200* _scalingFactor///(220 )
                               // ( s.height/6)
                               /PTM_RATIO
                               ); // bottom-left corner
    
    // Call the body factory which allocates memory for the ground body
    // from a pool and creates the ground box shape (also from a pool).
    // The body is also added to the world.
    groundBody = world->CreateBody(&groundBodyDef);
    groundBody->SetFixedRotation(false);
    
    // Define the ground box shape.
    b2EdgeShape groundBox;
    
    // bottom
    groundBox.Set(b2Vec2(0,0), b2Vec2(s.width  ,0));
    groundBody->CreateFixture(&groundBox,0);
    
    // top
    groundBox.Set(b2Vec2(0,s.height   ), b2Vec2(s.width ,s.height ));
    groundBody->CreateFixture(&groundBox,0);
    
    // left
    groundBox.Set(b2Vec2(0,s.height ), b2Vec2(0,0));
    groundBody->CreateFixture(&groundBox,0);
    
    // right
    groundBox.Set(b2Vec2(s.width ,s.height ), b2Vec2(s.width  ,0));
    groundBody->CreateFixture(&groundBox,0);
    
}

-(void)CalculateScalingFactor
{
    _scalingFactor = 700.0f / (TowerSize +PLANET_HEIGHT_BALANCE                               //self.pPlanetLayer.pPlanetSprite.boundingBox.size.height
                               );
    // _scalingFactor = 0.6;
    
    if(_scalingFactor > 1) _scalingFactor = 0.8f;
    
    _isZooming = YES;
    _positionBeforeZoom = self.position;
    
    _zoomOutPosition = _positionBeforeZoom;
    
    id zoomIn = [CCScaleTo actionWithDuration:0.5f scale:_scalingFactor];
    id calculatePosition = [CCCallBlock actionWithBlock:^{
        _zoomOutPosition = self.position;
        _zoomOutPosition.y += TowerSize*_scalingFactor/2;
        self.position = _zoomOutPosition;
        
    }];
    id reset = [CCCallBlock actionWithBlock:^{
        _isZooming = NO;
    }];
    id sequence = [CCSequence actions:zoomIn, reset, calculatePosition, nil];
    
    [self runAction:sequence];
    
}


-(void)drawAllPhysicsBlocsOfTower
{
    int x = 350; //* _scalingFactor;
    int y = 200* _scalingFactor;
    
    int i =1;
    int max, min, ytmp;
    int Move = 0;
    int tmp = 0;
    bool newBloc = true;
    
    CGPoint Base;
    b2Vec2 vertices[100];
    /*
     // Dernier troncon soumis a l'attaque
     if(WindAttackType)
     {
     max = [self._pTowerData Size];
     min = round([self._pTowerData Size] / 3);
     }
     //Premier troncon soumis à l'attaque
     else
     {
     max = round([self._pTowerData Size] / 3);
     min = 1;
     }
     //Bloc central du troncon
     int Middle_Bloc = max - round(round([self._pTowerData Size] / 3) / 2);
     
     */
    NSMutableArray *TabSprite = [[NSMutableArray alloc] init];
    
    for (BlocData *bloc in self._pTowerData._aBlocs)
    {
        int gravityCenterOfBloc = ((bloc._scaledSize.width / 2))
        * _scalingFactor
        - (bloc._gravityCenter.x
           *_scalingFactor);
        
        CCSprite *pBlocSprite = [BlocManager GetSpriteFromModel:bloc];
        pBlocSprite.anchorPoint = ccp(0.0f,0.0f);
        
        [pBlocSprite setPosition:CGPointMake(gravityCenterOfBloc, 0)];
        
        [TabSprite addObject: pBlocSprite];
        
        if(newBloc)
        {
            std::vector<CGPoint> forme = [bloc GetPhysicalVertices];
            for(int j = forme.size() ; j >= 0  ; j--)
            {
                Base = forme[j];
                if(Base.y == 0 )
                {
                    vertices[tmp].Set( (double) Base.x/PTM_RATIO + gravityCenterOfBloc,(double) Base.y/PTM_RATIO);
                    tmp++;
                    CCLOG(@"Detection de nouveau bloc, on ajoute la base %0.2f x %02.f",(double)Base.x/PTM_RATIO ,(double)Base.y/PTM_RATIO);
                }
            }
            
            ytmp = y;
            tmp = 0;
        }
        //if(bloc._hasStalagmite)
        {
           /* CCPhysicsSprite* pBlocSprite = [CCPhysicsSprite node];
            
            for (int j = 0; j < [TabSprite count]; j++)
            {
                CCSprite *pBlocSprite = [BlocManager GetPhysicsSpriteFromModel:bloctmp];
                [pBlocSprite addChild: [TabSprite objectAtIndex:j]];
            }
            
            */
            //CCSprite *pBlocSprite = [BlocManager GetPhysicsSpriteFromModel:bloc];
            CCPhysicsSprite *pBlocSprite = [BlocManager GetPhysicsSpriteFromModel:bloc];
            pBlocSprite.anchorPoint = ccp(0.0f,0.0f);
            [self._aBlocsTowerSprite addObject:pBlocSprite];
            [self addChild:pBlocSprite];
            [self createBodyForPhysicSprite:pBlocSprite BlocData:bloc Point:CGPointMake(x, y) b2Vec2:vertices];
            CCLOG(@"Add sprite %0.2f x %02.f",(double)x + gravityCenterOfBloc,(double)y);
            
            [pBlocSprite setPosition:CGPointMake(x, y)];
            newBloc = true;
            [TabSprite removeAllObjects];
            y += (bloc._scaledSize.height * _scalingFactor);
        }
        //  else
        newBloc = true;
        /***** Decalage due a l'attaque du vent *****
         
         //Si on se rapproche du centre de l'attaque, on ajoute du decalage
         if(i <= Middle_Bloc && i >= min && i <= max)
         {
         Move++;
         x = x-Move;
         }
         //Sinon c'est qu'on a passé le point critique, on réduit le decalage
         else if(i > Middle_Bloc && i >= min && i <= max)
         {
         Move--;
         x = x-Move;
         }
         //Cas ou l'on a depassé le rayon de l'attaque
         else if (i > max)
         x = 350 * _scalingFactor;
         
         CCLOG(@"Move : %0.2f, Bloc : %0.2f, Millieux : %0.2f, Min: %0.2f , Max : %0.2f",(double)Move, (double) i, (double) Middle_Bloc, (double) min, (double) max);
         /********************************************/
        
        //y += (bloc._scaledSize.height / 2);//* _scalingFactor;
        //y += pBlocSprite.boundingBox.size.height / 2;
        
        //int gravityCenterOfBloc = pBlocSprite.boundingBox.size.width / 2 - bloc._gravityCenter.x;
        
        
        
        i++;
        
    }
    
}



-(void)createBodyForPhysicSprite:(CCPhysicsSprite*)sprite BlocData:(BlocData*)b Point:(CGPoint)p b2Vec2:(b2Vec2*) Base
{
    std::vector<CGPoint> forme = [b GetPhysicalVertices];
    CGPoint pointTmp;
    
    CCLOG(@"Add body %0.2f x %02.f",p.x,p.y);
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    bodyDef.userData = sprite;
    
    b2Body *body = world->CreateBody(&bodyDef);
    
    b2Vec2 vertices[100];
    int j =1;
    //  CCLOG(@"Call Addbloc");
    for(int i = forme.size()-1 ; i >= 0  ; i--)
    {
        
        pointTmp = forme[i];
        //Ajout des coordonnées 0,0 du premier bloc
        /* if((double) pointTmp.y/PTM_RATIO == 0)
         {
         vertices[i].Set( Base[j].x,Base[j].y);
         CCLOG(@"Add base %0.f x %0.f at i = %0.f ",Base[j].x,Base[j].y, (double)i);
         j--;
         }
         else*/
        
        vertices[i].Set( (double) pointTmp.x/PTM_RATIO,(double) pointTmp.y/PTM_RATIO);
        
        CCLOG(@"Add point %0.f x %0.f at i = %0.f",vertices[i].x,vertices[i].y, (double) i);
    }
    
    b2PolygonShape polygonShape;
    polygonShape.Set(vertices, forme.size()); //pass array to the shape
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &polygonShape;
    fixtureDef.density = 10.0f;
    fixtureDef.friction = 1;
    //fixtureDef.isSensor = true;
    
    // Pas de rebond
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


-(void)rotateGroundWorld: (id)sender data:(void*)data
{
    
    NSNumber* dataNum = (NSNumber*) data;
    int degree = [dataNum intValue];
    
    CGSize s = [[CCDirector sharedDirector] winSize];
    int i = [self._pTowerData Size];
    
    // CCLOG(@"Rotation a %02.f", (double)degree);
    
    for(b2Body *b = world->GetBodyList(); b; b=b->GetNext())
    {
        
        if (b != groundBody)
        {
            if(i == 1)//[self._pTowerData Size] )
            {
                b->SetLinearVelocity(b2Vec2(0, 0));
                b->SetAngularVelocity(0);
            }
            else
            {
                b->SetTransform(b->GetPosition(), CC_DEGREES_TO_RADIANS(-degree * 0.4 ));
                if(b->GetPosition().y <=  (180* _scalingFactor  /PTM_RATIO +1) && b != groundBody)
                {
                    
                    CCLOG(@"Destruction %0.2f vs %0.2f ", b->GetPosition().y, (s.height/6  /PTM_RATIO +1));
                    
                    for(b2JointEdge *j=b->GetJointList();j;j=j->next){
                        b2Joint *jj=j->joint;
                        world->DestroyJoint(jj);
                    }
                    if(!world->IsLocked())
                    {
                        world->DestroyBody(b);
                        CCPhysicsSprite *Bloc = (CCPhysicsSprite *)  b->GetUserData();
                        id fadeOut = [CCFadeOut actionWithDuration:0.4];
                        
                        [Bloc runAction:fadeOut];
                        [self._pTowerData Remove:i-1];
                        [RemovedBlocs addIndex:i-1];
                        // [self removeChild:Bloc cleanup:YES];
                        
                    }
                    
                }
            }
            i--;
        }
    }
}

-(void)ApplyWindAttackLeft
{
    int degree = -2;
    
    int i = [self._pTowerData Size];
    
    for(b2Body *b = world->GetBodyList(); b; b=b->GetNext())
    {
        
        if (b != groundBody)
        {
            if(i == 1)//[self._pTowerData Size] )
            {
                b->SetLinearVelocity(b2Vec2(0, 0));
                b->SetAngularVelocity(0);
                
            }
            else
            {
                b->SetTransform(b->GetPosition(), CC_DEGREES_TO_RADIANS(-degree ));
            }
            i--;
        }
    }
}

-(void)ApplyWindAttackRight
{
    int degree = 1;
    
    int i = [self._pTowerData Size];
    
    for(b2Body *b = world->GetBodyList(); b; b=b->GetNext())
    {
        
        if (b != groundBody)
        {
            if(i == 1)//[self._pTowerData Size] )
            {
                b->SetLinearVelocity(b2Vec2(0, 0));
                b->SetAngularVelocity(0);
                
            }
            else
            {
                b->SetTransform(b->GetPosition(), CC_DEGREES_TO_RADIANS(-degree ));
            }
            i--;
        }
    }
}


-(void)ApplyWindAttack:(b2Vec2)p withForce:(float)f excludeBody:(b2Body *)eb {
    if (f < 1.0f) f = 1.0f;
    {
        
        b2Body* node = world->GetBodyList();
        while (node) {
            b2Body* b = node;
            node = node->GetNext();
            if (NULL != b && eb != b && nil != b->GetUserData()) {
                b2Vec2 direction = b->GetWorldCenter() - p;
                if (0.0f == direction.x) direction.x = 0.1f;
                if (0.0f == direction.y) direction.y = 0.1f;
                b2Vec2 impulse = b2Vec2(1.0f/direction.x * f, 1.0f/direction.y * f);
                if (b2_dynamicBody == b->GetType()) {  // Do this here only for dynamic bodies
                    b->ApplyLinearImpulse(impulse, b->GetWorldCenter());
                }
            }
        }
        
        
    }
    
    
}


@end
