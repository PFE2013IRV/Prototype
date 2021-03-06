//
//  GlobalConfig.h
//  ProjectTowe
//
//  Created by Karim Le Nir Aboul-Enein on 18/12/2013.
//  Copyright (c) 2013 Karim Le Nir Aboul-Enein. All rights reserved.
//

#ifndef ProjectTower_GlobalConfig_h
#define ProjectTower_GlobalConfig_h


// Time mode Balance
static float TIME_FOR_BALANCE = 25.0f;

// float pour le volume de la musique
static float VOLUME_CONSTRUCTION = 4.0f;
static float VOLUME_BALANCE = 1.0f;

static float WIND_GOD_ATTACK_TIME = 100;

static float FIRE_BALLS_SPEED = 180;

// Temps entre deux attaques de feu
static float TIME_FIRE_ATTACK = 5;

// Respect du dieu élémentaire par défaut
static float GOD_RESPECT_DEFAULT = 100;

// Respect gagné par destruction d'attaques divines
static float GOD_RESPECT_INCREASE = 4.0;

// Respect gagné en sortie de colère de dieu
static float GOD_RESPECT_GIFT = 7;

// Seuil de colère du dieu
static int GOD_ANGER_LIMIT = 30;

// Seuil du passage à l'orange de l'état du dieu
static int GOD_WARNING_LIMIT = 40;

// Mettre à true pour mode optimal
static bool SIMULATOR_MODE = false;
//Hauteur du placement de la planet pour la scene de construction
static int PLANET_HEIGHT_BALANCE = 250;

// Hauteur avant scroll de tour
static float SCROLLING_HEIGHT = 600.0f;

// Scrolling Speed
static float SCROLLING_SPEED_COEF = 2.0;

// Bloc's bounding box minimum width or height
static float BLOC_WIDTH = 80.0f;

// Bubble point
static float BUBBLE_POINT_X = 384.0f;
static float BUBBLE_POINT_Y = 900.0f;

//The different size element
static int BACKGROUND_WIDTH = 768;
static int BACKGROUND_HEIGHT = 1024;

//Game Time
static int GAME_TIME_CONSTRUCTION = 150;

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
