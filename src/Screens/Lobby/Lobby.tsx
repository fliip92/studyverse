import React, {FC, useEffect, useRef} from 'react';
import {Button, View} from 'react-native';
import {TwilioVideoCallModule, VideoRendererView} from '../../modules';
import Config from 'react-native-config';
import {styles} from './styles';
import {MainScreenProps} from './types';

const Lobby: FC<MainScreenProps> = () => {
  const videoViewRef = useRef<any>();

  useEffect(() => {
    if (videoViewRef.current) {
      TwilioVideoCallModule.setVideoView(videoViewRef.current);
    }
  }, []);

  const onJoinRoom = async () => {
    // TwilioVideoCallModule.setVideoView(videoViewRef.current);
    await TwilioVideoCallModule.joinRoom(
      'felipesRoom',
      Config.ACCESS_TOKEN as string,
    );
  };

  return (
    <View style={styles.container}>
      {/* <VideoRendererView ref={videoViewRef} style={styles.videoView} /> */}
      <Button title="Join Room" onPress={onJoinRoom} />
    </View>
  );
};

export default Lobby;
