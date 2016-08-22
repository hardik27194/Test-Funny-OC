//
//  FunnyModel.h
//  Funny
//
//  Created by yanzhen on 15/9/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

/************NoteModel*********************/
@interface NoteModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *noteTitle;
@property (nonatomic, copy) NSString *noteTime;
@end
/************SecretModel*********************/
@interface  SecretModel: NSObject<NSCoding>
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *remarks;
- (void)setValueForDictionary:(NSDictionary *)dict;
@end
/************weSee*********************/
@interface WeSeeModel : NSObject
//标题 一张图片 三张图片 URL 来源
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *thumb;
@property (strong, nonatomic) NSArray *extra;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *account_name;
//第一次 上拉 min_time=（behot_time） since_id=（oid）<第一项>
//第二次 上拉 。。。
//第一次  下拉 max_time=（behot_time） max_id=(oid)<最后一项>
//第二次  下拉 。。。

//拼接 (since_id=) (min_time=)
@property (nonatomic, copy) NSString *oid;
//hot 没有此项
@property (nonatomic, copy) NSString *behot_time;
//输入时间
@property (nonatomic, copy) NSString *input_time;
@property (nonatomic, copy) NSString *article_id;
@end
/************Sina视频*********************/
@interface SinaVideoModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *kpic;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, strong) NSDictionary *video_info;
@end
/************Sina新闻*********************/
@interface SinaNewsModel : NSObject
// 标题 小标题 图片 网址 多图片
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *kpic;
@property (nonatomic, copy) NSString *link;
//->list(NSArray)->(NSDictionary)->kpic
@property (nonatomic, strong) NSDictionary *pics;
@end
@interface FunnyModel : NSObject

@end
/************网易新闻*********************/
@interface NetEaseDefaultModel : NSObject
//主标题  副标题 时间 来源 url 源URL
@property (nonatomic, copy) NSString *title;
//段子只需要这一个
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, copy) NSString *ptime;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *url_3w;
//一张图片
@property (nonatomic, copy) NSString *imgsrc;
//三张图片会有 2Dict->imgsrc
@property (nonatomic, strong) NSArray *imgextra;

@end



/************UCNews*********************/
@interface UCNewsModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *origin_src_name;
@property (nonatomic, copy) NSString *original_url;
@property (nonatomic, copy) NSNumber *style_type;
@property (nonatomic, copy) NSNumber *publish_time;
//url = 每个图片
@property (nonatomic, strong) NSArray *thumbnails;
@end

/************内涵福利社*********************/
@interface WalfareTextModel : NSObject
@property (copy, nonatomic) NSString *update_time;
@property (copy, nonatomic) NSString *wbody;
@end
@interface WalfarePictureModel : NSObject
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *wbody;
@property (nonatomic, copy) NSString *wpic_m_height;
@property (nonatomic, copy) NSString *wpic_m_width;
@property (nonatomic, copy) NSString *wpic_middle;
@property (nonatomic, copy) NSString *is_gif;
@end
@interface WalfareVideoModel : NSObject
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *wbody;
@property (nonatomic, copy) NSString *vpic_small;
@property (nonatomic, copy) NSString *vplay_url;
@property (nonatomic, copy) NSString *vsource_url;
@end
@interface WalfareGirlModel : NSObject
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *wbody;
@property (nonatomic, copy) NSString *wpic_m_height;
@property (nonatomic, copy) NSString *wpic_m_width;
@property (nonatomic, copy) NSString *wpic_middle;
@property (nonatomic, copy) NSString *wpic_large;
@property (nonatomic, copy) NSString *is_gif;
@end
/************百思不得姐*********************/
//picture
@interface BuDeJiePictureModel : NSObject
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *cdn_img;
@property (nonatomic, copy) NSString *is_gif;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *width;
@end
//video
@interface BuDeJieVideoModel : NSObject
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *bimageuri;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *videouri;
@property (nonatomic, copy) NSString *weixin_url;
@end
//text
@interface BuDeJieTextModel : NSObject
@property (copy, nonatomic) NSString *profile_image;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *create_time;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *weixin_url;
@end
/**************快手************************/
@interface SomeWhatPictureModel : NSObject
//group->user->avatar_url // name 头像 昵称
@property (copy, nonatomic) NSString *avatar_url;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSNumber *create_time;
@property (copy, nonatomic) NSString *text;
//middle_image->r_width//r_height
@property (assign, nonatomic) NSNumber *r_width;
@property (assign, nonatomic) NSNumber *r_height;
//middle_image->url_list->url
@property (copy, nonatomic) NSString *url;
@end

@interface GifShowOutModel : NSObject
@property (assign, nonatomic) long long llsid;
@property (assign, nonatomic) int new_notify;
@property (assign, nonatomic) int pcursor;
@property (assign, nonatomic) int result;
@end

@interface GifShowVideoModel : NSObject
//头像 时间 昵称 图片 视频地址
@property (copy, nonatomic) NSString *main_url;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *user_name;
@property (copy, nonatomic) NSString *thumbnail_url;
@property (copy, nonatomic) NSString *main_mv_url;
@end
/****************内涵段子 段子***************/
//外层model
@interface ContextTextOutModel : NSObject
//@property (strong, nonatomic) NSArray *data;
@property (assign, nonatomic) BOOL has_more;
@property (assign, nonatomic) BOOL has_new_message;
@property (assign, nonatomic) long long max_time;
@property (assign, nonatomic) long long min_time;
@property (copy, nonatomic) NSString *tip;
@end
@interface ContentTextModel : NSObject
@property (copy, nonatomic) NSString *avatar_url;
@property (assign, nonatomic)long long create_time;
@property (assign, nonatomic)long long digg_count;
@property (assign, nonatomic)long long group_id;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *user_name;
@property (copy, nonatomic) NSString *user_profile_image_url;
@end
@interface ContextTextGroupModel : NSObject
@property (copy, nonatomic) NSString *category_name;
@property (assign, nonatomic) long long create_time;
@property (copy, nonatomic) NSString *share_url;
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) NSDictionary *user;
//avatar_url   name
@end
//**************************picture
@interface ContentPictureDataModel : NSObject
@property (assign, nonatomic) BOOL has_more;
@property (assign, nonatomic) BOOL has_new_message;
@property (assign, nonatomic) long long max_time;
@property (assign, nonatomic) long long min_time;
@end
@interface ContentPictureCommentModel : NSObject
@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *text;
@end
@interface ContentPictureGroupModel : NSObject
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *text;
@property (assign, nonatomic) NSNumber *create_time;
//group->middle_image
@property (nonatomic, assign) NSNumber *r_height;
@property (nonatomic, assign) NSNumber *r_width;
@property (nonatomic, copy) NSString *url;
//user
@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, copy) NSString *name;
@end
//***************************video
@interface ContentVideoDataModel : NSObject
@property (assign, nonatomic) BOOL has_more;
@property (assign, nonatomic) BOOL has_new_message;
@property (assign, nonatomic) long long max_time;
@property (assign, nonatomic) long long min_time;
@end
@interface ContentVideoCommentsModel : NSObject
@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *text;
@end
@interface ContentVideoGroupModel : NSObject
//user
@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, copy) NSString *name;
//
@property (assign, nonatomic) NSNumber *create_time;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *mp4_url;
@property (nonatomic, assign) NSNumber *duration;
//group->(large_cover) medium_cover->url_list—>url
//image
@property (nonatomic, copy) NSString *imageURL;
//360p_video 480p_video (720p_video) origin_video
@property (nonatomic, assign) NSNumber *width;
@property (nonatomic, assign) NSNumber *height;
//->url_list->  video
@property (nonatomic, copy) NSString *url;
@end