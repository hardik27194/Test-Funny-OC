//
//  GeneralEnum.h
//  Funny
//
//  Created by yanzhen on 15/9/25.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#ifndef Funny_GeneralEnum_h
#define Funny_GeneralEnum_h
//app
typedef enum {
    kApp_Content = 100,
    kApp_GifShow,
    kApp_BuDeJie,
    kApp_Walfare,
    kApp_UCNews,
    kApp_NetEaseNews,
    kApp_SinaNews,
    kApp_SinaVideo,
    kApp_Secret,
    kApp_DrawPictures,
    kApp_Note,
    kApp_QRCode,
    kApp_aMap
} eAppName;

//add
typedef enum{
    kScreenshot=0,
    kScreenPart,
    kHomePage,
    kExit
}eAddFunction;
//上拉，下拉，或者
typedef enum {
    kPullRefresh=-1,
    kNormalrefresh=0,
    kPushRefresh=1
}eRefresh;
// secret
typedef enum{
    yV2=0,
    yApple,
    yMail,
    yGame,
    yBaidu,
    yQQ,
    yAlibaba,
    yOther,
    yNow
}eSecretAddOrModify;
#endif
