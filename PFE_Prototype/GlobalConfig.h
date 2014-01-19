//
//  GlobalConfig.h
//  ProjectTower
//
//  Created by Karim Le Nir Aboul-Enein on 18/12/2013.
//  Copyright (c) 2013 Karim Le Nir Aboul-Enein. All rights reserved.
//

#ifndef ProjectTower_GlobalConfig_h
#define ProjectTower_GlobalConfig_h

// Bloc's bounding box minimum width or height
static float BLOC_WIDTH = 100.0f;

// Bubble point
static CGPoint BUBBLE_POINT = CGPointMake(300, 300);
//The different size element
static int BACKGROUND_WIDTH = 768;
static int BACKGROUND_HEIGHT = 877;
// The gamescene modes
enum GameSceneMode {
    SCENE_MODE_NULL = 0,
    SCENE_MODE_CONSTRUCTION = 1,
    SCENE_MODE_BALANCE = 2
};
typedef enum GameSceneMode GameSceneMode;



// The different elementary god types
enum GodType {
    GOD_TYPE_NULL = 0,
    GOD_TYPE_FIRE = 1,
    GOD_TYPE_WATER = 2,
    GOD_TYPE_EARTH = 3
};
typedef enum GodType GodType;

// Materials are defined here in this enum
enum Material {
    MAT_NULL = 0,
    MAT_WOOD = 1,
    MAT_GLASS = 2
};
typedef enum Material Material;

// Possible bloc bag sizes are defined n this enum
enum BagSize {
    BAG_SIZE_NULL = 0,
    BAG_SIZE_SMALL = 5,
    BAG_SIZE_MEDIUM = 10,
    BAG_SIZE_BIG = 20,
    BAG_SIZE_GOD_LIKE = 50
};
typedef enum BagSize BagSize;


#endif
