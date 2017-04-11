//
//  ViewController.m
//  testPermission
//
//  Created by 董小云 on 2017/4/11.
//  Copyright © 2017年 董力云. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>//相册

@interface ViewController ()

    @property (nonatomic, strong) UIButton * audioType;
    @property (nonatomic, strong) UIButton * videoType;
    @property (nonatomic, strong) UIButton * photoLibraryType;
    
    @property (nonatomic, assign) NSString* audioStatus;
    @property (nonatomic, assign) NSString* videoStatus;
    @property (nonatomic, assign) NSString* photoLibraryStatus;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.audioType = [[UIButton alloc] initWithFrame:CGRectMake(10,100 , 350, 50)];
    [self.audioType setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.audioType ];
    [self.audioType addTarget:self action:@selector(audioAuthAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.videoType = [[UIButton alloc] initWithFrame:CGRectMake(10, 180, 350, 50)];
    [self.videoType setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:self.videoType];
    [self.videoType addTarget:self action:@selector(videoAuthAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.photoLibraryType = [[UIButton alloc] initWithFrame:CGRectMake(10, 250, 350, 50)];
    [self.photoLibraryType setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:self.photoLibraryType];
    [self.photoLibraryType addTarget:self action:@selector(phontLibraryAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self checkAudioStatus];
    [self checkVideoStatus];
    [self checkPhotoStauts];
}

    
//授权麦克风
- (void)audioAuthAction
{
       [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
           NSLog(@"%@",granted ? @"麦克风准许":@"麦克风不准许");
           [self checkAudioStatus];
       }];
}
 //授权相机
- (void)videoAuthAction
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        NSLog(@"%@",granted ? @"相机准许":@"相机不准许");
        [self checkVideoStatus];
    }];
}
//授权照片
- (void)phontLibraryAction{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        [self checkPhotoStauts];
    }];
}
//检查麦克风权限
- (void) checkAudioStatus{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
        //没有询问是否开启麦克风
        self.audioStatus = @"AVAuthorizationStatusNotDetermined";
        break;
        case AVAuthorizationStatusRestricted:
        //未授权，家长限制
        self.audioStatus = @"AVAuthorizationStatusRestricted";
        break;
        case AVAuthorizationStatusDenied:
        //玩家未授权
        self.audioStatus = @"AVAuthorizationStatusDenied";
        break;
        case AVAuthorizationStatusAuthorized:
        //玩家授权
        self.audioStatus = @"AVAuthorizationStatusAuthorized";
        break;
        default:
        break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.audioType setTitle:self.audioStatus forState:UIControlStateNormal];
    });
}
//检查相机权限
- (void) checkVideoStatus
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
        //没有询问是否开启相机
        self.videoStatus = @"AVAuthorizationStatusNotDetermined";
        break;
        case AVAuthorizationStatusRestricted:
        //未授权，家长限制
        self.videoStatus = @"AVAuthorizationStatusRestricted";
        break;
        case AVAuthorizationStatusDenied:
        //未授权
        self.videoStatus = @"AVAuthorizationStatusDenied";
        break;
        case AVAuthorizationStatusAuthorized:
        //玩家授权
        self.videoStatus = @"AVAuthorizationStatusAuthorized";
        break;
        default:
        break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.videoType setTitle:self.videoStatus forState:UIControlStateNormal];
    });
}
//检查照片权限
- (void) checkPhotoStauts{
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthorStatus) {
        case PHAuthorizationStatusAuthorized:
        self.photoLibraryStatus = @"PHAuthorizationStatusAuthorized";
        break;
        case PHAuthorizationStatusDenied:
        self.photoLibraryStatus = @"PHAuthorizationStatusDenied";
        break;
        case PHAuthorizationStatusNotDetermined:
        self.photoLibraryStatus = @"PHAuthorizationStatusNotDetermined";
        break;
        case PHAuthorizationStatusRestricted:
        self.photoLibraryStatus = @"PHAuthorizationStatusRestricted";
        break;
        default:
        break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.photoLibraryType setTitle:self.photoLibraryStatus forState:UIControlStateNormal];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
