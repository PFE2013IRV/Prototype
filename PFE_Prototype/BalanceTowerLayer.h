//
//  BalanceTowerLayer.h
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 27/12/2013.
//  Copyright 2013 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TowerLayer.h"
#import "TowerData.h"

#import "Box2D.h"
#import "GLES-Render.h"
#define PTM_RATIO 32
//1433

@interface BalanceTowerLayer : TowerLayer {
    CCTexture2D *spriteTexture_;	// weak ref
	b2World* world;					// strong ref
	GLESDebugDraw *m_debugDraw;		// strong ref
}

-(id) initWithTowerData : (TowerData*) i_pTowerData;

@end
