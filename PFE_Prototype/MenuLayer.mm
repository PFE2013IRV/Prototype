//
//  MenuLayer.m
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 17/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "MenuLayer.h"
#import "BlocManager.h"


@implementation MenuLayer

@synthesize pBagData = _pBagData;
@synthesize pScrollLayer = _pScrollLayer;

-(id) init
{
    if (self = [super init])
    {
        _pBagData = [BlocBagData GetBlocBagData];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        int nbPage = [_pBagData._aBlocs count] / 6;
        if ([_pBagData._aBlocs count]%6 != 0)
        {
            nbPage ++;
        }
        
        NSMutableArray *layerArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < nbPage; i++)
        {
            CCLayer *layer = [[CCLayer alloc] init];
            CCMenu *addMenu;
            NSArray *itemArray;
            
            if (i == nbPage - 1 && [_pBagData._aBlocs count]%6 != 0)
            {
                itemArray = [NSArray arrayWithArray:[self makeMenuItemForOnePage:[_pBagData._aBlocs count]%6 FirstForkCpt:i]];
            }
            else
            {
                itemArray = [NSArray arrayWithArray:[self makeMenuItemForOnePage:6 FirstForkCpt:i]];
            }
            
            addMenu = [CCMenu menuWithArray:itemArray];
            addMenu.position = ccp(0, 0);
            [layer addChild:addMenu];
            [layerArray addObject:layer];
        }
        
        
        CCSprite* pMenuBkg = [CCSprite spriteWithFile:@"MenuBkg.png"];
        pMenuBkg.anchorPoint = ccp(0.0f,0.0f);
        pMenuBkg.position = ccp(9.0f,9.0f);
        _pScrollLayer = [CCScrollLayer nodeWithLayers:layerArray widthOffset:screenSize.width * [layerArray count]];
        [self addChild:pMenuBkg];
        [self addChild:_pScrollLayer];
    }
    
    return self;
}


-(NSArray*)makeMenuItemForOnePage:(int)nbItemInPage FirstForkCpt:(int)tag
{
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    
    for (int y = 0; y < nbItemInPage; y++)
    {
        int nbOfBloc = y + tag * 6;
        
        BlocData *bloc = [_pBagData._aBlocs objectAtIndex:nbOfBloc];
        
        CCSprite* blocSprite = [BlocManager GetSpriteFromModel:bloc];
        
        CCMenuItemSprite* addButtonSprite = [CCMenuItemSprite itemWithNormalSprite:blocSprite selectedSprite:nil target:self selector:@selector(addBloc:)];
        
        float scaleFactor = 0.0f;
        
        if(bloc._scaledSize.height > bloc._scaledSize.width)
            scaleFactor = BLOC_WIDTH / bloc._scaledSize.height;
        else
            scaleFactor = BLOC_WIDTH / bloc._scaledSize.width;
        
        addButtonSprite.scaleY = scaleFactor;
        addButtonSprite.scaleX = scaleFactor;
        
        addButtonSprite.anchorPoint = ccp(0.5f,0.0f);
        addButtonSprite.position = ccp(84 + y * 120, 30);
        addButtonSprite.tag = nbOfBloc;
        
        [itemArray addObject:addButtonSprite];
    }
    
    return itemArray;
}


-(void)addBloc:(CCMenuItemImage*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(BlocHasBeenSelected:)])
    {
        [self.delegate BlocHasBeenSelected:[_pBagData._aBlocs objectAtIndex:sender.tag]];
    }
}

@end
