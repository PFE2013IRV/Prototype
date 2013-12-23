//
//  BlocData.m
//  Blocs
//
//  This class provides a data model for the blocs
//

#import "BlocData.h"

@implementation BlocData

@synthesize _aVertices;
@synthesize _eBlocMaterial;
@synthesize _sFileName;


-(id) initBloc : (NSArray*)i_aVertices withMaterial: (Material)i_eBlocMaterial
{
    if(i_aVertices.count == 0 )
    {
        NSLog(@"Fatal error : bloc data init failed");
        return nil;
    }
    
    else if(i_eBlocMaterial == MAT_NULL)
    {
        NSLog(@"Fatal error : bloc data init failed");
        return nil;
    }
    
    else if (self = [super init])
    {
        _aVertices = [[NSMutableArray alloc] initWithArray:i_aVertices];
        _eBlocMaterial = i_eBlocMaterial;
        _sFileName = [[NSString alloc] initWithString:@""];
    }
    
    return self;    
}

-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    
    return nil;
}

@end
