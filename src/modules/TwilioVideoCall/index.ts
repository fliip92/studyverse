import {NativeModules} from 'react-native';
import VideoView from '../VideoView';

const {TwilioVideoCallModule: NativeTwilioVideoCallModule} = NativeModules;

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
  VideoView,
};

export default TwilioVideoCallModule;
