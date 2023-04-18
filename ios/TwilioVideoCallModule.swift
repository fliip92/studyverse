import Foundation
import TwilioVideo
import React

@objc(TwilioVideoCallModule)
class TwilioVideoCallModule: RCTEventEmitter, RoomDelegate, CameraSourceDelegate {
  
  @objc override func supportedEvents() -> [String] {
    return [] // Return an empty array for now, you can add your event names later
  }
  
  @objc override func constantsToExport() -> [AnyHashable: Any] {
     return [:]
   }
   
  override static func moduleName() -> String {
     return "TwilioVideoCallModule"
   }
  
  override init() {
    super.init()
    print("TwilioVideoCallModule initialized")
  }

  var room: Room?
  var localVideoTrack: LocalVideoTrack?
  var localAudioTrack: LocalAudioTrack?
  var camera: CameraSource?
  
  // video rendering
  private var videoView: VideoRenderer?

  @objc func setVideoView(_ videoView: VideoRenderer) {
    self.videoView = videoView
  }
  
  private var joinRoomResolver: RCTPromiseResolveBlock?
  private var joinRoomRejecter: RCTPromiseRejectBlock?
  
  @objc func joinRoom(_ roomName: String, accessToken: String, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
    self.prepareLocalMedia()

    self.joinRoomResolver = resolver
    self.joinRoomRejecter = rejecter

    let connectOptions = ConnectOptions(token: accessToken) { builder in
      if let localAudioTrack = self.localAudioTrack {
        builder.audioTracks = [localAudioTrack]
      }
      if let localVideoTrack = self.localVideoTrack {
        builder.videoTracks = [localVideoTrack]
      }
      builder.roomName = roomName
    }

    room = TwilioVideoSDK.connect(options: connectOptions, delegate: self)
  }

  func prepareLocalMedia() {
    if (localVideoTrack == nil) {
      camera = CameraSource(delegate: self)
      localVideoTrack = LocalVideoTrack(source: camera!)
    }

    if (localAudioTrack == nil) {
      localAudioTrack = LocalAudioTrack()
    }

    if let camera = self.camera, let videoTrack = self.localVideoTrack {
      camera.startCapture(device: <#T##AVCaptureDevice#>){_,_,_ in
        videoTrack.addRenderer(self.videoView!)
      }
    }
  }

  @objc func disconnect() {
    room?.disconnect()
    room = nil
  }

  @objc func isConnected(_ callback: RCTResponseSenderBlock) {
    callback([(room?.state == .connected)])
  }

  // RoomDelegate methods
  func roomDidConnect(room: Room) {
    // Handle room connection
    joinRoomResolver?(room.name)
  }

  func roomDidDisconnect(room: Room, error: Error?) {
    // Handle room disconnection
    if let error = error {
      joinRoomRejecter?("ROOM_CONNECTION_FAILED", "Failed to connect to the room: \(error.localizedDescription)", error)
    }
  }
}
