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


-(id) initWithData : (NSArray*)i_vertices : (Material)i_blocMaterial
{
    if(i_vertices.count == 0 )
    {
        NSLog(@"Fatal error : bloc data init failed");
        return nil;
    }
    
    else if(i_blocMaterial == MAT_NULL)
    {
        NSLog(@"Fatal error : bloc data init failed");
        return nil;
    }
    
    else if (self = [super init])
    {
        _aVertices = [[NSMutableArray alloc] initWithArray:i_vertices];
        _eBlocMaterial = i_blocMaterial;
        _sFileName = [[NSString alloc] initWithString:@""];
    }
    
    return self;    
}

@end
