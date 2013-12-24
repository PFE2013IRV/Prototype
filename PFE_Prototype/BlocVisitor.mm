//
//  BlocVisitor.m
//  ProjectTower
//
//  The BlocVisitor is a singleton, capable to draw a bloc view from a BlocModel,
//  read the blocs in the bloc bag and write new blocs in the bloc bag.
//

#import "BlocVisitor.h"
#import "BlocBagData.h"

@implementation BlocVisitor

// Instance variable for the bloc visitor
static BlocVisitor* pBlocVisitor = nil;

-(CCSprite*) GetSpriteFromModel: (BlocData*) i_pData
{
    CCSprite* pSprite = nil;
    
    if(i_pData)
    {
        NSLog(@"Begin Bloc Sprite creation");
        
        pSprite = [[[CCSprite alloc] init] autorelease];
        
        // To be implemented : create a sprite from a Bloc Data
        
        NSLog(@"End Bloc Sprite creation");
    }
    return pSprite;
}


-(void) SaveBloc: (BlocData*) i_pData
{
    if(i_pData)
    {
        NSLog(@"Begin Save Bloc");
        // To be implemented : writing the data in the save file
        
        NSLog(@"End Save Bloc");
    }
    else
    {
        NSLog(@"Error : bloc could not be saved. Data was corrupted");
    }
}


-(void) LoadBlocsToBlocBag
{
    BlocBagData* pBlocBagData = nil;
    // Get the bloc bag data instance
    pBlocBagData = [BlocBagData GetBlocBagData];
    
    if(pBlocBagData)
    {
        NSLog(@"Begin load bloc data");
        
        //  To be implemented : retrieve data from the save file and load it to the bloc bag data
        
        NSLog(@"End load bloc data");
    }
    else
    {
        [NSException raise:NSInternalInconsistencyException format:@"Error : bloc could not load the blocs. Data was corrupted"];
    }
}

-(void) MakePNGFromModel: (BlocData*) i_pData
{
    if(i_pData)
    {
        NSLog(@"Begin write PNG Bloc");
        
        // To be implemented
        
        NSLog(@"End write PNG Bloc");
    }
    else
    {
        [NSException raise:NSInternalInconsistencyException format:@"Error : bloc could write PNG file. Data was corrupted"];
    }
}

+(BlocVisitor*) GetBlocVisitor
{
    if(!pBlocVisitor)
    {
        [[self alloc] init];
    }
    
    return pBlocVisitor;
}

+(id) alloc
{
    pBlocVisitor = [super alloc];
    return pBlocVisitor;
}

-(id) init
{
    
    if(self = [super init])
    {
        // Init of the bloc visitor
    }
    
    return self;
}


@end
