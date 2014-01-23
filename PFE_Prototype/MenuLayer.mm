//
//  MenuLayer.m
//  PFE_Prototype
//
//  Created by Alexandre Jegouic on 17/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "MenuLayer.h"


@implementation MenuLayer

@synthesize pBagData = _pBagData;

-(id) init
{
    if (self = [super init])
    {
        _pBagData = [BlocBagData GetBlocBagData];
    }
    
    return self;
}

@end
