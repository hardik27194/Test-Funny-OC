//
//  GifShowMacro.m
//  Funny
//
//  Created by yanzhen on 16/7/14.
//  Copyright © 2016年 Y&Z. All rights reserved.
//


/*************************快手*********************/
//写死的接口----post请求？？？？？？？很多问题
NSString *const GifShowHeadURL = @"http://api.gifshow.com/rest/n/feed/list?type=7&lat=39.975431&lon=116.338496&ver=4.34&ud=0&sys=ANDROID_4.2.1&c=XIAOMI&net=WIFI&did=ANDROID_41099610831fa8ef&mod=Xiaomi%282013022%29&app=0&language=zh-cn&country_code=CN";
NSString *const GifShowTest = @"os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=030d2819371a88871dfdcef832f8d553";
//有点意思
NSString *const SomeWhatDefaultPictureURL = @"http://ic.snssdk.com/neihan/stream/category/data/v3/?screen_width=720&category_id=12&level=6&count=20&iid=3127363017&device_id=3037163715&ac=wifi&channel=xiaomi&aid=27&app_name=joke_zone&version_code=220&device_platform=android&device_type=2013022&os_api=17&os_version=4.2.1&uuid=864312021030956&openudid=41099610831fa8ef";
NSString *const SomeWhatPullHeadURL = @"http://ic.snssdk.com/neihan/stream/category/data/v3/?screen_width=720&category_id=12&level=6&count=20&min_time=";
NSString *const SomeWhatPushHeadURL = @"http://ic.snssdk.com/neihan/stream/category/data/v3/?screen_width=720&category_id=12&level=6&count=20&max_time=";
NSString *const SomeWhatDefaultFootURL = @"&iid=3127363017&device_id=3037163715&ac=wifi&channel=xiaomi&aid=27&app_name=joke_zone&version_code=220&device_platform=android&device_type=2013022&os_api=17&os_version=4.2.1&uuid=864312021030956&openudid=41099610831fa8ef";
//



NSString *const GifShowPage1 = @"os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=030d2819371a88871dfdcef832f8d553";
NSString *const GifShowPage2 = @"os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=2&pcursor=1&pv=false&mtype=2&type=7&sig=e36d8ea8f8467cbe7249308aee2ebff6";
NSString *const GifShowPage3 = @"os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=3&pcursor=1&pv=false&mtype=2&type=7&sig=99dbc70c2400608033ef75eb2a0e5d32";
NSString *const GifShowPage4 = @"os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=4&pcursor=1&pv=false&mtype=2&type=7&sig=9d3ddddf8e5f1bcd1245e51b350e386f";
NSString *const GifShowPage5 = @"os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=5&pcursor=1&pv=false&mtype=2&type=7&sig=97f5a97fef823c93a87103748427926a";
NSString *const GifShowPage6 = @"os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=6&pcursor=1&pv=false&mtype=2&type=7&sig=f2e0152a41aa5da7cc5ad319a2eab52b";
//上拉
NSString *const GifShowDown1 = @"os=android&client_key=3c2cd3f3&last=543&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=5f4fc7265650f27d32326f7b55e03f4d";
NSString *const GifShowDown2 = @"os=android&client_key=3c2cd3f3&last=107&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=de7e9abc2cf9621c54520da169941f43";
NSString *const GifShowDown3 = @"os=android&client_key=3c2cd3f3&last=69&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=c4aec912c4d5f4091b36ed79746e9e7c";
NSString *const GifShowDown4 = @"os=android&client_key=3c2cd3f3&last=60&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=d4a0b2798391cd1dddea0fda0d8b57a5";
NSString *const GifShowDown5 = @"os=android&client_key=3c2cd3f3&last=53&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=06f239d06cf6dd3e5392642c8c593508";



