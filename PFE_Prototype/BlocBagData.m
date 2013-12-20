//
//  BlocBagData.m
//  ProjectTower
//
//  The BlocBagData contains the data related to the bloc bag (content, max size, etc...)
//  It's a singleton object.
//

#import "BlocBagData.h"

@implementation BlocBagData

@synthesize _aBlocs;
@synthesize _eBagSize;

// Instance variable for the bloc bag data
static BlocBagData* pBlocBagData = nil;


-(void) SetBlocBagData : (BagSize) i_eBagSize : (NSArray*) i_aBlocs
{
    if(!i_aBlocs) return;
    else if(i_eBagSize < i_aBlocs.count)
    {
        NSLog(@"Fatal error :  too many blocs for the bag size. Please check the save file data");
        return;
    }
    else if(!(i_eBagSize == BAG_SIZE_NULL || i_eBagSize == BAG_SIZE_SMALL || i_eBagSize == BAG_SIZE_MEDIUM
       || i_eBagSize == BAG_SIZE_BIG || i_eBagSize == BAG_SIZE_GOD_LIKE))
    {
        NSLog(@"Fatal error :  the bag size is different from the legal values. Please check the save file data");
        return;
    }
    else
    {
        [_aBlocs removeAllObjects];
        [_aBlocs initWithArray:i_aBlocs];
        
        _eBagSize = i_eBagSize;
    }
}

+(BlocBagData*) GetBlocBagData
{
    @synchronized([BlocBagData class])
    {
        if(!pBlocBagData)
        {
            [[self alloc] init];
            
            return pBlocBagData;
        }
    }
    return nil;
}

+(id) alloc
{
    @synchronized([pBlocBagData class])
    {
        pBlocBagData = [super alloc];
        return pBlocBagData;
    }
    return nil;
}

-(id) init
{
    
    if(self = [super init])
    {
        _eBagSize = BAG_SIZE_NULL;
        _aBlocs = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
