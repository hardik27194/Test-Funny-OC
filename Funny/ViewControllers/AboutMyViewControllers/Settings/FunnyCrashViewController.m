//
//  FunnyCrashViewController.m
//  Funny
//
//  Created by yanzhen on 16/11/10.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "FunnyCrashViewController.h"

@interface FunnyCrashViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, copy) NSString *lastLog;
@end

@implementation FunnyCrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Crash Log";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"last" style:UIBarButtonItemStylePlain target:self action:@selector(lastCrashLog)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [document stringByAppendingPathComponent:@"FunnyCrash.log"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *log = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *array = [log componentsSeparatedByString:@"Crash time    :*** -"];
    if (array.count >= 2) {
        self.textView.text = log;
        _lastLog = array.lastObject;
    }else{
        _lastLog = @"No Crash Log";
        self.textView.text = @"No Crash Log";
    }

}

- (void)lastCrashLog{
    _textView.text = _lastLog;
}

@end
