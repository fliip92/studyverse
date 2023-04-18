import React, {FC, useRef} from 'react';
import {Button, View} from 'react-native';
import {TwilioVideoCallModule} from '../../modules';
import Config from 'react-native-config';
import {styles} from './styles';
import {MainScreenProps} from './types';

const {VideoView} = TwilioVideoCallModule;

const Lobby: FC<MainScreenProps> = () => {
  const videoViewRef = useRef();

  const onJoinRoom = async () => {
    TwilioVideoCallModule.setVideoView(videoViewRef.current);
    await TwilioVideoCallModule.joinRoom(
      'felipesRoom',
      Config.ACCESS_TOKEN as string,
    );
  };

  return (
    <View style={styles.container}>
      <VideoView ref={videoViewRef} style={{width: '100%', height: '100%'}} />
      <Button title="Join Room" onPress={onJoinRoom} />
    </View>
  );
};

export default Lobby;
