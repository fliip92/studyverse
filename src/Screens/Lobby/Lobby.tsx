import React, {FC} from 'react';
import {View} from 'react-native';
import {styles} from './styles';
import {MainScreenProps} from './types';

const Lobby: FC<MainScreenProps> = () => {
  return <View style={styles.container} />;
};

export default Lobby;
