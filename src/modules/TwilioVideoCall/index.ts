import {NativeModules} from 'react-native';

const {TwilioVideoModule: NativeTwilioVideoCallModule} = NativeModules;

const TwilioVideoCallModule = {
  joinRoom: async (roomName: string, accessToken: string) => {
    return NativeTwilioVideoCallModule.joinRoom(roomName, accessToken);
  },
  disconnect: () => {
    NativeTwilioVideoCallModule.disconnect();
  },
  isConnected: async () => {
    return NativeTwilioVideoCallModule.isConnected();
  },
  setVideoView: (videoView: any) => {
    NativeTwilioVideoCallModule.setVideoView(videoView);
  },
};

export default TwilioVideoCallModule;
