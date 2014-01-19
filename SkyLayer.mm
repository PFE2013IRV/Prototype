//
//  SkyLayer.m
//
//  Definition of the sky layer. This class implements several mechnanisms for the dynamic sky
//  (gradients, interpolation with noise image...)
//

// Import the interfaces
#import "SkyLayer.h"
#import "math.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


// HelloWorldLayer implementation
@implementation SkyLayer

@synthesize _pAnimation;
@synthesize _pAnimate;
@synthesize _pBackground;
@synthesize _backgroundHeight,_backgroundWidth;
@synthesize _velocityFactor;
@synthesize  _nbSecondToPlay,
_nbSecondPlayed,
_currentMomentOfDay,
_incrementR,
_incrementG,
_incrementB;

@synthesize _currentBackgroundColor;
@synthesize _aimedBackgroundColor;


@synthesize _sceneMod;





// on "init" you need to initialize your instance
-(id) init{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        //Taille à changer!!!
        _backgroundHeight = BACKGROUND_HEIGHT;
        _backgroundWidth =  BACKGROUND_WIDTH;
        
	}
	return self;
}

-(void) initColorsOfDay
{
    _nbSecondToPlay = 12;
    _velocityFactor = 0.1;
    
    _nbSecondToPlay = _nbSecondToPlay*(1/_velocityFactor);
    _nbSecondPlayed = 0;
    
    
    
    /* Base couleur */
    
    ccColor4B dawn = ccc4(152, 188, 228, 255);
    ccColor4B morning = ccc4(128, 171, 219, 255);
    ccColor4B middleMorning = ccc4(112, 171, 219, 255);
    ccColor4B noon = ccc4(95, 145, 201, 255);
    ccColor4B afternoon = ccc4(89, 129, 174, 255);
    ccColor4B evening = ccc4(81, 117, 157, 255);
    ccColor4B night = ccc4(67, 98, 132, 255);
    ccColor4B midnight = ccc4(44, 73, 104, 255);
    ccColor4B dark = ccc4(18, 41, 68, 255);
    
    _aPaintColors[0] = dawn;
    _aPaintColors[1] = morning;
    _aPaintColors[2] = middleMorning;
    _aPaintColors[3] = noon;
    _aPaintColors[4] = afternoon;
    _aPaintColors[5] = evening;
    _aPaintColors[6] = night;
    _aPaintColors[7] = midnight;
    _aPaintColors[8] = dark;
    
    
    
    _aTimeScale[0] = 0;
    for(int i=1; i<=8;i++)
    {
        _aTimeScale[i] = _nbSecondToPlay/8*i;
    }
    
    _currentBackgroundColor = _aPaintColors[0];
    _currentMomentOfDay=0;
    _aimedBackgroundColor = _aPaintColors[_currentMomentOfDay+1];
    
    _incrementR = (_aimedBackgroundColor.r - _currentBackgroundColor.r)/ (_aTimeScale[1]);
    _incrementG = (_aimedBackgroundColor.g - _currentBackgroundColor.g)/ (_aTimeScale[1]);
    _incrementB = (_aimedBackgroundColor.b - _currentBackgroundColor.b)/ (_aTimeScale[1]);
    
    _pAnimation = [[CCAnimation alloc]init];
    
}



-(void) genBackground {
    
    ccColor4F bgColor =  ccc4FFromccc4B(_currentBackgroundColor);
    CCTexture2D *newTexture = [self spriteWithColor:bgColor textureWidth:_backgroundWidth textureHeight:_backgroundHeight];
    
    if (!_pBackground)
    {
        CGSize winSize = [[CCDirector sharedDirector]winSize];
        _pBackground = [CCSprite spriteWithTexture:newTexture];
        _pBackground.position = (ccp(_backgroundWidth/2,_backgroundHeight/2+winSize.height-_backgroundHeight));
        
        [self addChild:_pBackground z:-1];
    }
    else
    {
        [_pBackground setTexture:newTexture];
    }
}


-(CCTexture2D *)spriteWithColor:(ccColor4F)bgColor textureWidth:(float)textureWidth textureHeight:(float)textureHeight {
    
    CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:textureWidth height:textureHeight];
    [rt beginWithClear:bgColor.r g:bgColor.g b:bgColor.b a:bgColor.a];
    
    /* Noise */
    
    CCSprite *noise = [CCSprite spriteWithFile:@"noise.png"];
    [noise setBlendFunc:(ccBlendFunc){GL_DST_COLOR,GL_ZERO}];
    noise.position = ccp(textureWidth/2,textureHeight/2);
    [noise visit];
    
    
    
    [rt end];
    
    return rt.sprite.texture;
    
    
}

-(void) callChange:(ccTime)i_dt
{
    [self changeBackground:i_dt];
}

-(void) changeBackground:(ccTime)i_dt
{
    NSLog(@"i_dt: %f",i_dt);
    _nbSecondPlayed ++;
    if(_nbSecondPlayed < _aTimeScale[_currentMomentOfDay+1])
    {
        ccColor4B newColor = ccc4(_currentBackgroundColor.r + _incrementR, _currentBackgroundColor.g + _incrementG, _currentBackgroundColor.b + _incrementB, 255);
        _currentBackgroundColor = newColor;
        
    }
    else
    {
        _currentMomentOfDay++;
        if(_currentMomentOfDay <9)
        {
            
            _aimedBackgroundColor = _aPaintColors[_currentMomentOfDay+1];
            _incrementR = (_aimedBackgroundColor.r - _currentBackgroundColor.r)/ (_aTimeScale[_currentMomentOfDay+1]-_aTimeScale[_currentMomentOfDay]);
            _incrementG = (_aimedBackgroundColor.g - _currentBackgroundColor.g)/ (_aTimeScale[_currentMomentOfDay+1]-_aTimeScale[_currentMomentOfDay]);
            _incrementB = (_aimedBackgroundColor.b - _currentBackgroundColor.b)/(_aTimeScale[_currentMomentOfDay+1]-_aTimeScale[_currentMomentOfDay]);
            
            ccColor4B newColor = ccc4(_currentBackgroundColor.r + _incrementR, _currentBackgroundColor.g + _incrementG, _currentBackgroundColor.b + _incrementB, 255);
            _currentBackgroundColor = newColor;
            
        }
        else
        {
            [self unschedule:@selector(changeBackground:)];
            
        }
    }
    
    [self genBackground ];
}

-(void)ManageBackgroundConstruction
{
    self._sceneMod = SCENE_MODE_CONSTRUCTION;
    [self initColorsOfDay];
    
    [self schedule:@selector(changeBackground:)interval:_velocityFactor];
    
    
}
-(void)ManageBackgroundBalance
{
    self._sceneMod = SCENE_MODE_BALANCE;
    [self initColorsOfDay];
    
    //On prend une couleur aléatoire comme couleur de fond parmis le tableau des couleurs
    int alea = arc4random() %9;
    self._currentBackgroundColor = _aPaintColors[alea];
    [self genBackground];
    
}

-(void) update:(ccTime)delta
{
    [self changeBackground:delta];
    
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
-(void) onEnter
{
    [super onEnter];
    //[self schedule:@selector(changeBackground:)interval:_velocityFactor];
    
}
-(void) onExit
{
    
    [self unschedule:@selector(changeBackground:)];
    [super onExit];
}

@end