//
//  YZShareInstance.h
//  Funny
//
//  Created by yanzhen on 15/11/9.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#ifndef Funny_YZShareInstance_h
#define Funny_YZShareInstance_h

#define HShareInstance(name) + (instancetype)share##name;

#if __has_feature(objc_arc)

#define MShareInstance(name) \
static id instance; \
\
+ (instancetype)share##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance=[[self alloc] init]; \
}); \
return instance; \
} \
\
+(instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance=[super allocWithZone:zone]; \
}); \
return instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return instance; \
}

#else
#define MShareInstance(name) \
static id instance; \
+ (instancetype)share##name\
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance=[[self alloc] init]; \
}); \
return instance; \
} \
\
+(instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance=[super allocWithZone:zone]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
return instance; \
} \
\
- (oneway void)release { } \
- (id)retain { return self; } \
- (NSUInteger)retainCount { return 1;} \
- (id)autorelease { return self;}

#endif


#endif
