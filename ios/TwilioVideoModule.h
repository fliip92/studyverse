//
//  TwilioVideoModule.h
//  studyverse
//
//  Created by Felipe Loyola on 4/18/23.
//
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <TwilioVideo/TwilioVideo.h>

@interface TwilioVideoModule : RCTEventEmitter <RCTBridgeModule, TVIRoomDelegate, TVICameraSourceDelegate>
@end
