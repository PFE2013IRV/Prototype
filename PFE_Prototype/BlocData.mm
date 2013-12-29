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
@synthesize _originalSize;




-(id) initBloc : (NSArray*)i_aVertices withMaterial: (Material)i_eBlocMaterial
{
    if(i_aVertices.count == 0 )
    {
       [NSException raise:NSInternalInconsistencyException format:@"Fatal error : bloc data init failed"];
        return nil;
    }
    
    else if(i_eBlocMaterial == MAT_NULL)
    {
       [NSException raise:NSInternalInconsistencyException format:@"Fatal error : bloc data init failed"];
        return nil;
    }
    
    else if (self = [super init])
    {
        _aVertices = [[NSMutableArray alloc] initWithArray:i_aVertices];
        _eBlocMaterial = i_eBlocMaterial;
        
        
        // Création d'un filename unique associé au PNG.
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        CFStringRef sUUIDString = CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
        //NSString* sFolder = [NSString stringWithUTF8String:PNG_FLODER];
        NSString* sPrefix = @"Bloc_";
        NSString* sExtension = @".png";
        
        NSString* sUniqueFileName = [NSString stringWithFormat:@"%@%@%@",sPrefix, (NSString *)sUUIDString, sExtension];
        CFRelease(sUUIDString);
        
        _sFileName = [[NSString alloc] initWithString:sUniqueFileName];
    }
    
    return self;    
}

-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return self;
}

@end
