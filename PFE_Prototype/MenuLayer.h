//
//  MenuLayer.h
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 17/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BlocData.h"
#import "BlocBagData.h"

@protocol MenuDelegate <NSObject>

@required
-(void)BlocHasBeenSelected:(BlocData*)blocSelected;

@end // end of delegate protocol


@interface MenuLayer : CCLayer
{
    id <MenuDelegate> _delegate;
}

-(id) init;

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) BlocBagData *pBagData;

@end
