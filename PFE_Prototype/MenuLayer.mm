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
        
        int nbPage = round([_pBagData._aBlocs count] / 6 + 0.5);
        
        NSMutableArray *layerArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < nbPage; i++)
        {
            CCLayer *layer = [[CCLayer alloc] init];
            CCMenu *addMenu;
            NSMutableArray *itemArray = [[NSMutableArray alloc] init];
            
            if (i == nbPage - 1)
            {
                for (int y = 0; y < [_pBagData._aBlocs count]%6; y++)
                {
                    int nbOfBloc = y + i * 6;
                    
                    BlocData *bloc = [_pBagData._aBlocs objectAtIndex:nbOfBloc];
                    NSString *pictName = [BlocManager GetNameOfPictureFromModel:bloc];
                    
                    CCMenuItemImage *addButton = [CCMenuItemImage itemWithNormalImage:pictName selectedImage:pictName target:self selector:@selector(addBloc:)];
                    
                    float scaleFactor = 100 / bloc._scaledSize.height;
                    addButton.scaleY = scaleFactor;

                    addButton.position = ccp(84 + y * 120, 69);
                    addButton.tag = nbOfBloc;
                    
                    [itemArray addObject:addButton];
                }
            }
            else
            {
                for (int y = 0; y < 6; y++)
                {
                    int nbOfBloc = y + i * 6;
                    
                    BlocData *bloc = [_pBagData._aBlocs objectAtIndex:nbOfBloc];
                    NSString *pictName = [BlocManager GetNameOfPictureFromModel:[_pBagData._aBlocs objectAtIndex:nbOfBloc]];
                    
                    CCMenuItemImage *addButton = [CCMenuItemImage itemWithNormalImage:pictName selectedImage:pictName target:self selector:@selector(addBloc:)];
                    
                    float scaleFactor = 100 / bloc._scaledSize.height;
                    addButton.scaleY = scaleFactor;
                    
                    addButton.position = ccp(84 + y * 120, 69);
                    addButton.tag = nbOfBloc;
                    
                    [itemArray addObject:addButton];
                }
            }
            
            addMenu = [CCMenu menuWithArray:itemArray];
            addMenu.position = ccp(0, 0);
            [layer addChild:addMenu];
            [layerArray addObject:layer];
        }
        
        
        _pScrollLayer = [CCScrollLayer nodeWithLayers:layerArray widthOffset:screenSize.width * [layerArray count]];
        [self addChild:_pScrollLayer];
    }
    
    return self;
}


-(void)addBloc:(CCMenuItemImage*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(BlocHasBeenSelected:)])
    {
        [self.delegate BlocHasBeenSelected:[_pBagData._aBlocs objectAtIndex:sender.tag]];
    }
}

@end
