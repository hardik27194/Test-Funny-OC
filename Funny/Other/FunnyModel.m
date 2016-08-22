//
//  FunnyModel.m
//  Funny
//
//  Created by yanzhen on 15/9/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "FunnyModel.h"
/************NoteModel*********************/
@implementation NoteModel

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_noteTitle forKey:@"noteTitle"];
    [aCoder encodeObject:_noteTime forKey:@"noteTime"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        _noteTitle=[aDecoder decodeObjectForKey:@"noteTitle"];
        _noteTime=[aDecoder decodeObjectForKey:@"noteTime"];
    }
    return self;
}

@end

/************SecretModel*********************/
@implementation SecretModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_company forKey:@"company"];
    [aCoder encodeObject:_account forKey:@"account"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_remarks forKey:@"remarks"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        _company=[aDecoder decodeObjectForKey:@"company"];
        _account=[aDecoder decodeObjectForKey:@"account"];
        _password=[aDecoder decodeObjectForKey:@"password"];
        _remarks=[aDecoder decodeObjectForKey:@"remarks"];
    }
    return self;
}
- (void)setValueForDictionary:(NSDictionary *)dict
{
    self.company=dict[@"company"];
    self.account=dict[@"account"];
    self.password=dict[@"password"];
    self.remarks=dict[@"remarks"];
}
@end

/************weSee*********************/
@implementation WeSeeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end


@implementation FunnyModel

@end

/************Sina视频*********************/
@implementation SinaVideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
/************Sina新闻*********************/
@implementation SinaNewsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
/************网易新闻*********************/
@implementation NetEaseDefaultModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
/************UCNews*********************/
@implementation UCNewsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
/************内涵福利社*********************/
@implementation WalfareTextModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
@implementation WalfarePictureModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
@implementation WalfareVideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
@implementation WalfareGirlModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
/************百思不得姐*********************/
@implementation BuDeJiePictureModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
@implementation BuDeJieVideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
@implementation BuDeJieTextModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
/*************快手************/
@implementation SomeWhatPictureModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
@implementation GifShowOutModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

@implementation GifShowVideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end









/*************内涵段子************/
@implementation ContextTextOutModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
@implementation ContentTextModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
@implementation ContextTextGroupModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
//picture
@implementation ContentPictureDataModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
@implementation ContentPictureCommentModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
@implementation ContentPictureGroupModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
//****************video
@implementation ContentVideoDataModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
@implementation ContentVideoCommentsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
@implementation ContentVideoGroupModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end