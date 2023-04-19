//
//  TwilioVideoModule.m
//  studyverse
//
//  Created by Felipe Loyola on 4/18/23.
//
#import "TwilioVideoModule.h"
#import <React/RCTUIManager.h>

@interface TwilioVideoModule ()

@property (nonatomic, strong) TVIRoom *room;
@property (nonatomic, strong) TVILocalVideoTrack *localVideoTrack;
@property (nonatomic, strong) TVILocalAudioTrack *localAudioTrack;
@property (nonatomic, strong) TVICameraSource *camera;

@property (nonatomic, strong) TVIVideoView *videoView;

@property (nonatomic, copy) RCTPromiseResolveBlock joinRoomResolver;
@property (nonatomic, copy) RCTPromiseRejectBlock joinRoomRejecter;

@end

@implementation TwilioVideoModule

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
  return @[];
}

- (NSDictionary *)constantsToExport {
  return @{};
}

RCT_EXPORT_METHOD(setVideoView:(nonnull NSNumber *)reactTag) {
  UIView *view = [self.bridge.uiManager viewForReactTag:reactTag];
  if ([view isKindOfClass:[TVIVideoView class]]) {
    self.videoView = (TVIVideoView *)view;
  }
}

RCT_EXPORT_METHOD(joinRoom:(NSString *)roomName accessToken:(NSString *)accessToken resolver:(RCTPromiseResolveBlock)resolver rejecter:(RCTPromiseRejectBlock)rejecter) {
  [self prepareLocalMedia];
  
  self.joinRoomResolver = resolver;
  self.joinRoomRejecter = rejecter;
  
  TVIConnectOptions *connectOptions = [TVIConnectOptions optionsWithToken:accessToken
                                                                    block:^(TVIConnectOptionsBuilder * _Nonnull builder) {
    builder.roomName = roomName;
    if (self.localAudioTrack) {
      builder.audioTracks = @[self.localAudioTrack];
    }
    if (self.localVideoTrack) {
      builder.videoTracks = @[self.localVideoTrack];
    }
  }];
  
  self.room = [TwilioVideoSDK connectWithOptions:connectOptions delegate:self];
}

- (void)prepareLocalMedia {
  if (!self.localVideoTrack) {
    self.camera = [[TVICameraSource alloc] initWithDelegate:self];
    self.localVideoTrack = [TVILocalVideoTrack trackWithSource:self.camera];
  }
  
  if (!self.localAudioTrack) {
    self.localAudioTrack = [TVILocalAudioTrack track];
  }
  
  if (self.camera && self.localVideoTrack && self.videoView) {
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [self.camera startCaptureWithDevice:captureDevice
                             completion:^(AVCaptureDevice * _Nonnull device, TVIVideoFormat * _Nonnull format, NSError * _Nullable error) {
      if (error) {
        NSLog(@"Error starting capture: %@", error.localizedDescription);
      } else {
        [self.localVideoTrack addRenderer:self.videoView];
      }
    }];
  }
}

RCT_EXPORT_METHOD(disconnect) {
  [self.room disconnect];
  self.room = nil;
}

+ (BOOL)requiresMainQueueSetup {
  return YES; // Or return NO if your module doesn't need to be set up on the main queue.
}

@end

