# push notification firebase 2

## persiapan

1. buat project Firebase

2. setup android di **Project Settings** di **Firebase console**

3. install `react-native-firebase` (dokumentasi: [rnfirebase.io](https://rnfirebase.io))

   ```bash
   npm install --save @react-native-firebase/app
   yarn add @react-native-firebase/app
   npx pod-install
   ```

4. ikutin konfigurasi di rnfirebase.io

5. push notification menggunakan fitur **Firebase Cloud Messaging** (FCM), oleh karena itu install

   ```bash
   npm install --save @react-native-firebase/messaging
   yarn add @react-native-firebase/messaging
   npx pod-install
   ```

## koding

6. buat fungsi untuk mengaktifkan fcm (request izin FCM) di `./helpers/notification.js`
   ```js
   import messaging from '@react-native-firebase/messaging';
   
   export const requestUserPermission = async () => {
     const authStatus = await messaging().requestPermission();
     const enabled =
       authStatus === messaging.AuthorizationStatus.AUTHORIZED ||
       authStatus === messaging.AuthorizationStatus.PROVISIONAL;
   
     if (enabled) {
       console.log('Authorization status:', authStatus);
       getFcmToken();
     }
   }
   ```

2. install `react-native-async-storage` (https://github.com/re…)
   https://react-native-async-storage.github.io/async-storage/docs/install/

   ```bash
   npm install @react-native-async-storage/async-storage
   yarn add @react-native-async-storage/async-storage
   ```

3. buat fungsi untuk memperoleh FCM token
   ```js
   const getFcmToken = async () => {
     let fcmToken = await AsyncStorage.getItem("fcmToken");
     console.log(fcmToken, "token lama");
     
     if (!fcmToken) { // kalo gk ada tokennya
       try {
         const fcmToken = await messaging().getToken();
         
         if (fcmToken) {
           console.log(fcmToken, "si token baru generated");
           await AsyncStorage.setItem("fcmToken", fcmToken);
         }
       } catch (error) {
         console.log("error", error.message);
         
       }
     }
   }
   ```

4. apply fungsi FCM ke `App.js`

   ```js
   import React from "react";
   import { requestUserPermission } from "./helpers/notification.js"
   
   export default function App() {
     useEffect(() => {
   		requestUserPermission();
     });
   }
   ```

5. apply notification
   ```js
    import React, { useState, useEffect } from 'react';
    import messaging from '@react-native-firebase/messaging';
    import { NavigationContainer, useNavigation } from '@react-navigation/native';
    import { createStackNavigator } from '@react-navigation/stack';
    
    const Stack = createStackNavigator();
    
    function App() {
      const navigation = useNavigation();
      const [loading, setLoading] = useState(true);
      const [initialRoute, setInitialRoute] = useState('Home');
    
      useEffect(() => {
        // Assume a message-notification contains a "type" property in the data payload of the screen to open
    
        messaging().onNotificationOpenedApp(remoteMessage => {
          console.log(
            'Notification caused app to open from background state:',
            remoteMessage.notification,
          );
          navigation.navigate(remoteMessage.data.type);
        });
    
        // Check whether an initial notification is available
        messaging()
          .getInitialNotification()
          .then(remoteMessage => {
            if (remoteMessage) {
              console.log(
                'Notification caused app to open from quit state:',
                remoteMessage.notification,
              );
              setInitialRoute(remoteMessage.data.type); // e.g. "Settings"
            }
            setLoading(false);
          });
      }, []);
    
      if (loading) {
        return null;
      }
    
      return (
        <NavigationContainer>
          <Stack.Navigator initialRouteName={initialRoute}>
            <Stack.Screen name="Home" component={HomeScreen} />
            <Stack.Screen name="Settings" component={SettingsScreen} />
          </Stack.Navigator>
        </NavigationContainer>
      );
    }
   ```

atawa bisa seperti ini

   ```js
   export const notificationListener = async () => {
     messaging().onNotificationOpenedApp(remoteMessage => {
       console.log("notification caused app to open from background state:", remoteMessage.notification);
     });
     
     messaging.onMessage(async remoteMessage => {
   		console.log("received in foreground", remoteMessage);
     });
     
     messaging().getInitialNotification().then(remoteMessage => {
       if (remoteMessage) {
   			console.log("notification caused app to open from quit state:", remoteMessage.notification);
       }
     });
   }
   ```
7. register ke `App.js`

```js
import React from "react";
import { requestUserPermission } from "./helpers/notification.js"

export default function App() {
  useEffect(() => {
		requestUserPermission();
    notificationListener();
  });
}
```

## testing

1. buka [fcm.snayak.dev](https://testfcm.com)
2. copy server key dari **Firebase console** (bagian **Server key**)
3. FCM Registration Token: copy token dari console log (`fcmToken`)
4. isi **Title**, **Body**, serta informasi lain yang diperlukan.

## register background notification

Di `index.js`

```js
// index.js
import { AppRegistry } from 'react-native';
import messaging from '@react-native-firebase/messaging';
import App from './App';

// Register background handler
messaging().setBackgroundMessageHandler(async remoteMessage => {
  console.log('Message handled in the background!', remoteMessage);
});

AppRegistry.registerComponent('app', () => App);
```

