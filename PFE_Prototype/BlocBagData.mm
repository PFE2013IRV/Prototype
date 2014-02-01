//
//  BlocBagData.m
//
//  The BlocBagData contains the data related to the bloc bag (content, max size, etc...)
//  It's a singleton object.
//

#import "BlocBagData.h"
#import "BlocManager.h"

@implementation BlocBagData

@synthesize _aBlocs;
@synthesize _eBagSize;
@synthesize _aBlocTextures;

// Instance variable for the bloc bag data
static BlocBagData* pBlocBagData = nil;

-(void) SetBlocBagData: (BagSize) i_eBagSize  withBlocs: (NSMutableArray*) i_aBlocs
{
    if(!i_aBlocs) return;
    else if(i_eBagSize < i_aBlocs.count)
    {
         [NSException raise:NSInternalInconsistencyException format:@"Fatal error :  too many blocs for the bag size. Please check the save file data"];
        return;
    }
    else if(!(i_eBagSize == BAG_SIZE_NULL || i_eBagSize == BAG_SIZE_SMALL || i_eBagSize == BAG_SIZE_MEDIUM
       || i_eBagSize == BAG_SIZE_BIG || i_eBagSize == BAG_SIZE_GOD_LIKE))
    {
         [NSException raise:NSInternalInconsistencyException format:@"Fatal error :  the bag size is different from the legal values. Please check the save file data"];
        return;
    }
    else
    {
        [_aBlocs removeAllObjects];
        [_aBlocs addObjectsFromArray:i_aBlocs];
        
        _eBagSize = i_eBagSize;
        
        // Création des sprites
        _aBlocTextures = [[NSMutableArray alloc] init];
        BlocManager* pBM = [BlocManager GetBlocManager];
        
        for(int i = 0 ; i < i_aBlocs.count; i++)
        {
            CCSprite* pSprite = [pBM GetTexturedSprite:[i_aBlocs objectAtIndex:i]];
            CCTexture2D* pTexture = pSprite.texture;
            [_aBlocTextures addObject:pTexture];
        }
        
    }
}

+(BlocBagData*) GetBlocBagData
{
    if(!pBlocBagData)
    {
        [[self alloc] init];
    }
    return pBlocBagData;
}

+(id) alloc
{
    pBlocBagData = [super alloc];
    return pBlocBagData;
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
