//
//  GodData.m
//
//
//  Model class for an elementary god. Encapsulates his type (fire, earth, water)
//  and his level of respect.
//

#import "GodData.h"

@implementation GodData

@synthesize _eGodType;
@synthesize _isActive;
@synthesize _respect;

-(id) initGod: (GodType) i_eGodType withDefaultRespect: (int)i_respect withActiveFlag: (bool) i_isActive
{
    if(!(i_eGodType == GOD_TYPE_EARTH || i_eGodType == GOD_TYPE_FIRE || i_eGodType == GOD_TYPE_WATER))
    {
        [NSException raise:NSInternalInconsistencyException format:@"Fatal error : unknown god type"];
        return nil;
    }
    else if (self = [super init])
    {
        _eGodType = i_eGodType;
        _respect = i_respect;
        _isActive = i_isActive;
    }
    return self;
}

-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return self;
}



@end
