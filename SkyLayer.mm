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
@synthesize _pBackground;
@synthesize _backgroundHeight,_backgroundWidth;
@synthesize _velocityFactor;
@synthesize  _nbSecondToPlay,
_currentMomentOfDay,
_timeScale;

@synthesize _currentBackgroundColor;
@synthesize _aimedBackgroundColor;


@synthesize _sceneMod;





// on "init" you need to initialize your instance
-(id) init{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        
        
	}
	return self;
}
-(void) initConstruction
{

    _backgroundHeight = BACKGROUND_HEIGHT;
    _backgroundWidth =  BACKGROUND_WIDTH;
    [self initColorsOfDay];
}
-(void)initBalance
{
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    _backgroundWidth = winSize.width;
    _backgroundHeight = winSize.height;
    [self initColorsOfDay];
}
-(void) initColorsOfDay
{
    _nbSecondToPlay = GAME_TIME_CONSTRUCTION;
    
    /* Base couleur */
    
    ccColor4B dawn = ccc4(159, 186, 245, 255);
    ccColor4B morning = ccc4(131, 161, 234, 255);
    ccColor4B middleMorning = ccc4(124, 160, 239, 255);
    ccColor4B noon = ccc4(98, 141, 236, 255);
    ccColor4B afternoon = ccc4(88, 129, 219, 255);
    ccColor4B evening = ccc4(126, 148, 198, 255);
    ccColor4B night = ccc4(84, 99, 133, 255);
    ccColor4B midnight = ccc4(49, 66, 103, 255);
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
    
    _timeScale = (float)_nbSecondToPlay/8;
    
    if(_sceneMod == SCENE_MODE_CONSTRUCTION)
    {
    _currentBackgroundColor = _aPaintColors[0];
    }
    else
    {
    //On prend une couleur aléatoire comme couleur de fond parmis le tableau des couleurs
    int alea = arc4random() %9;
    _currentBackgroundColor = _aPaintColors[alea];
    }
    
    _currentMomentOfDay=0;
    _aimedBackgroundColor = _aPaintColors[_currentMomentOfDay+1];
    
    [self initBackground];
   
    
    
}
-(void) initBackground
{
    
    CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:_backgroundWidth height:_backgroundHeight];
    [rt beginWithClear:_currentBackgroundColor.r g:_currentBackgroundColor.g b:_currentBackgroundColor.b a:255];
    [rt end];
    
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    _pBackground = [CCSprite spriteWithTexture:rt.sprite.texture];
    
    [_pBackground setColor:ccc3(_currentBackgroundColor.r, _currentBackgroundColor.g, _currentBackgroundColor.b)];
    _pBackground.position = (ccp(_backgroundWidth/2,_backgroundHeight/2+winSize.height-_backgroundHeight));
    
    [self addChild:_pBackground z:-1];
    
    CCSprite *noise = [CCSprite spriteWithFile:@"noise.png"];
    [noise setBlendFunc:(ccBlendFunc){GL_DST_COLOR,GL_ZERO}];
    noise.position = ccp(_backgroundWidth/2,_backgroundHeight/2+winSize.height-_backgroundHeight);
    [noise visit];
    [self addChild:noise];
    
    
}

-(void) changeBackground:(ccTime)i_dt
{
    
    _aimedBackgroundColor = _aPaintColors[_currentMomentOfDay+1];
  
        if(_currentMomentOfDay <8)
        {
            
            CCAction *changeColor = [CCTintTo actionWithDuration:_timeScale red:_aimedBackgroundColor.r green:_aimedBackgroundColor.g blue:_aimedBackgroundColor.b];
            [_pBackground runAction:changeColor];
            _currentMomentOfDay++;
        }
        else
        {
            [self unschedule:@selector(changeBackground:)];
            
        }
    }
    

-(void)ManageBackgroundConstruction
{
    self._sceneMod = SCENE_MODE_CONSTRUCTION;
    [self initConstruction];
    [self changeBackground:Nil];
    [self schedule:@selector(changeBackground:)interval:_timeScale];
    
}
-(void)ManageBackgroundBalance
{
    self._sceneMod = SCENE_MODE_BALANCE;
    [self initBalance];
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
   
    
}
-(void) onExit
{
    
    [self unschedule:@selector(changeBackground:)];
    [super onExit];
}

@end