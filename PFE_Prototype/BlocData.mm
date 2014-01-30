//
//  BlocData.m
//  Blocs
//
//  This class provides a data model for the blocs
//

#import "BlocData.h"

@implementation BlocData

@synthesize _aVertices;
@synthesize _aDrawingVertices;
@synthesize _eBlocMaterial;
@synthesize _sFileName;
@synthesize _originalSize;
@synthesize _scaledSize;
@synthesize _gravityCenter;
@synthesize _baseWidth;
@synthesize _hasSmallerBase;
@synthesize _specialBaseOffset;

-(id) initBloc : (NSArray*)i_aVertices withMaterial: (Material)i_eBlocMaterial
{
    if(i_aVertices.count == 0)
    {
       [NSException raise:NSInternalInconsistencyException format:@"Fatal error : bloc data init failed"];
    }
    
    else if(i_eBlocMaterial == MAT_NULL)
    {
       [NSException raise:NSInternalInconsistencyException format:@"Fatal error : bloc data init failed"];
    }
    
    else if (self = [super init])
    {
        _aVertices = [[NSMutableArray alloc] initWithArray:i_aVertices];
        _eBlocMaterial = i_eBlocMaterial;
        
        ////////////////////////////////////////////////////////////////
        ///////    Détermination d'un UUID pour le filename        /////
        ////////////////////////////////////////////////////////////////
        
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
        
        _hasSmallerBase = NO;
        
        ////////////////////////////////////////////////////////////////
        ///////        Calcul du original size du bloc.            /////
        ////////////////////////////////////////////////////////////////
        
        // Le original size est la taille de la boîte englobante de la forme au moment de sa création
        // (c'est à dire avant rescaling optimal pour le jeu)
    
        // calcul de la distance entre xmax, xmin et ymax, ymin
        
        CGPoint pointTmp = [[_aVertices objectAtIndex:0] CGPointValue];
        int xmin = pointTmp.x;
        int xmax = pointTmp.x;
        int ymin = pointTmp.y;
        int ymax = pointTmp.y;

        for(int i = 1 ; i < _aVertices.count ; i++)
        {
            pointTmp = [[_aVertices objectAtIndex:i] CGPointValue];
            int xTmp = pointTmp.x;
            int yTmp = pointTmp.y;
            
            if(xTmp < xmin)
                xmin = xTmp;
            if(yTmp < ymin)
                ymin = yTmp;
            
            if(xTmp > xmax)
                xmax = xTmp;
            if(yTmp > ymax)
                ymax = yTmp;
        }
        
        _originalSize.width = xmax - xmin;
        _originalSize.height = ymax - ymin;
        
        ////////////////////////////////////////////////////////////
        ///////       Décalage du bloc selon xmin/ymin       ///////
        ////////////////////////////////////////////////////////////
     
        // Tableau tampon
        NSMutableArray* aVerticesTmp = [[NSMutableArray alloc] init];
        
        if(!(xmin == 0 && ymin==0))
        {
            for(int i = 0 ; i < _aVertices.count ; i++)
            {
                // Translation de chaque coordonnée
                pointTmp = [[_aVertices objectAtIndex:i] CGPointValue];
                pointTmp.x = pointTmp.x - xmin;
                pointTmp.y = pointTmp.y - ymin;
                
                NSValue* pointValueTmp = [NSValue valueWithCGPoint:pointTmp];
                [aVerticesTmp addObject:pointValueTmp];
            }
            
            [_aVertices removeAllObjects];
            [_aVertices addObjectsFromArray:aVerticesTmp];
            
        }
 
        ////////////////////////////////////////////////////////////
        ///////   Calcul du rescaling du bloc à la taille    ///////
        ///////        standard des blocs dans le jeu.       ///////
        ////////////////////////////////////////////////////////////
        
        float scalingFactor = 0.0f;
        float scalingReference = 0.0;
        
        // Le scaling factor est calculé de façon à ce que le bloc ait une largeur de BLOC_WIDTH.
        scalingReference = _originalSize.width;
        scalingFactor = BLOC_WIDTH / scalingReference;
        
        // On réutiise le tableau tampon précédemment initialisé. Rafraichissement :
        [aVerticesTmp removeAllObjects];
        
        for(int i = 0 ; i < _aVertices.count ; i++)
        {
            // Calcul de chaque coordonnée
            pointTmp = [[_aVertices objectAtIndex:i] CGPointValue];
            pointTmp.x = pointTmp.x * scalingFactor;
            pointTmp.y = pointTmp.y * scalingFactor;
            
            NSValue* pointValueTmp = [NSValue valueWithCGPoint:pointTmp];
            [aVerticesTmp addObject:pointValueTmp];
        }
        
        [_aVertices removeAllObjects];
        [_aVertices addObjectsFromArray:aVerticesTmp];
        
        ////////////////////////////////////////////////////////////////
        ///////        Calcul du rescaled size du bloc.            /////
        ////////////////////////////////////////////////////////////////
        
        // Le rescaled size est la taille de la boîte englobante de la forme une fois redimensionnée
        // (c'est à dire après rescaling optimal pour le jeu)
        
        // calcul de la distance entre xmax, xmin et ymax, ymin
        
        pointTmp = [[_aVertices objectAtIndex:0] CGPointValue];
        xmin = pointTmp.x;
        xmax = pointTmp.x;
        ymin = pointTmp.y;
        ymax = pointTmp.y;
        
        for(int i = 1 ; i < _aVertices.count ; i++)
        {
            pointTmp = [[_aVertices objectAtIndex:i] CGPointValue];
            int xTmp = pointTmp.x;
            int yTmp = pointTmp.y;
            
            if(xTmp < xmin)
                xmin = xTmp;
            if(yTmp < ymin)
                ymin = yTmp;
            
            if(xTmp > xmax)
                xmax = xTmp;
            if(yTmp > ymax)
                ymax = yTmp;
        }
        
        _scaledSize.width = xmax - xmin;
        _scaledSize.height = ymax - ymin;
        
        ////////////////////////////////////////////////////////////////
        //////            Calcul du physical vector !              /////
        ////////////////////////////////////////////////////////////////
        
        [aVerticesTmp removeAllObjects];
        [aVerticesTmp addObjectsFromArray:_aVertices];
        
        // Variables utiles pour le traitement
        
        std::vector<int> aIndexesForYMinMax;
        CGPoint pointLeft, pointRight;
        NSValue* pointLeftValue = nil;
        NSValue* pointRightValue = nil;
        
        ///////////////////////////////////////////////////
        // On traite en premier les ymax
        // On récupère d'abord les index des points à ymax.
        
        for(int i=0 ; i < aVerticesTmp.count ; i++)
        {
            pointTmp = [[aVerticesTmp objectAtIndex:i] CGPointValue];
            
            if(pointTmp.y == ymax)
                aIndexesForYMinMax.push_back(i);
        }
        
        int sizeOfYmax = aIndexesForYMinMax.size();
        // S'il existe une "stalagmite"
        if(sizeOfYmax == 1)
        {
            int insertionIndex = aIndexesForYMinMax.at(0);
            
            pointTmp = [[aVerticesTmp objectAtIndex:insertionIndex] CGPointValue];
            
            // On divise le point en deux points, extrémités d'un segment de longueur 20% de BLOC_WIDTH.
            pointLeft = CGPointMake((pointTmp.x + (0.1*BLOC_WIDTH)), pointTmp.y);
            pointRight = CGPointMake((pointTmp.x - (0.1*BLOC_WIDTH)), pointTmp.y);
            
            pointLeftValue = [NSValue valueWithCGPoint:pointLeft];
            pointRightValue = [NSValue valueWithCGPoint:pointRight];
            
            [aVerticesTmp replaceObjectAtIndex:insertionIndex withObject:pointLeftValue];
            [aVerticesTmp insertObject:pointRightValue atIndex:insertionIndex+1];

        }
        
        aIndexesForYMinMax.clear();
        
        ///////////////////////////////////////////////////
        // On traite à présent les ymin
        // On récupère d'abord les index des points à ymin.
        
        for(int i=0 ; i < aVerticesTmp.count ; i++)
        {
            pointTmp = [[aVerticesTmp objectAtIndex:i] CGPointValue];
            
            if (pointTmp.y == ymin)
                aIndexesForYMinMax.push_back(i);
            
        }
        
        int sizeOfYmin = aIndexesForYMinMax.size();
        // S'il existe une "stalagtite"
        if(sizeOfYmin == 1)
        {
            int insertionIndex = aIndexesForYMinMax.at(0);
            
            pointTmp = [[aVerticesTmp objectAtIndex:insertionIndex] CGPointValue];
            
            // On divise le point en deux points, extrémités d'un segment de longueur 20% de BLOC_WIDTH.
            pointLeft = CGPointMake((pointTmp.x - (0.1*BLOC_WIDTH)), pointTmp.y);
            pointRight = CGPointMake((pointTmp.x + (0.1*BLOC_WIDTH)), pointTmp.y);
            
            pointLeftValue = [NSValue valueWithCGPoint:pointLeft];
            pointRightValue = [NSValue valueWithCGPoint:pointRight];
            
            [aVerticesTmp replaceObjectAtIndex:insertionIndex withObject:pointLeftValue];
            [aVerticesTmp insertObject:pointRightValue atIndex:insertionIndex+1];
            
            _baseWidth = 0;

        }// On en profite pour vérifier la base du bloc !
        else if(sizeOfYmin == 2)
        {
            int indexPt0 = aIndexesForYMinMax.at(0);
            int indexPt1 = aIndexesForYMinMax.at(1);
            
            CGPoint point0 = [[aVerticesTmp objectAtIndex:indexPt0] CGPointValue];
            CGPoint point1 = [[aVerticesTmp objectAtIndex:indexPt1] CGPointValue];
            
            _baseWidth = point1.x - point0.x;
            
            
            if(_baseWidth < 75)
            {
                _specialBaseOffset = point0.x + _baseWidth/2;
                _hasSmallerBase = YES;
                
            }
            
        }
        
        // On remplit le vector résultat avec les points traités pour le moteur physique.
        
        for(int i = 0 ; i < aVerticesTmp.count ; i++)
        {
            pointTmp = [[aVerticesTmp objectAtIndex:i] CGPointValue];
            _aPhysicalVertices.push_back(pointTmp);
        }
        
        ////////////////////////////////////////////////////////////////
        ///////          Calcul du centre de gravité             ///////
        ////////////////////////////////////////////////////////////////
        
        _gravityCenter = CGPointMake(0, 0);
        
        for(int i = 0 ; i < _aVertices.count; i++)
        {
            pointTmp = [[_aVertices objectAtIndex:i] CGPointValue];
            
            _gravityCenter.x += pointTmp.x;
            _gravityCenter.y += pointTmp.y;
            
        }
        
        _gravityCenter.x = _gravityCenter.x / _aVertices.count;
        _gravityCenter.y = _gravityCenter.y / _aVertices.count;
        
        ////////////////////////////////////////////////////////////////
        ///////             Init du drawing array               ////////
        ////////////////////////////////////////////////////////////////
        
        // Au moment de l'init, _aVertices et _aDrawingVertices sont les mêmes.
        _aDrawingVertices = [[NSMutableArray alloc] initWithArray:_aVertices];
        
    }
    
    return self;    
}

-(std::vector<CGPoint>) GetPhysicalVertices
{
    return _aPhysicalVertices;
}

-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return self;
}

@end
