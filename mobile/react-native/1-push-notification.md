# cara push notification ke react native

### instalasi

link repo: https://github.com/zo0r/react-native-push-notification

syarat tambahan khusus ios: [klik disini](#khusus-ios)

1. install `react-native-push-notification`
   | using Yarn                                                   | using npm                                                    |
   | ------------------------------------------------------------ | ------------------------------------------------------------ |
   | <code>yarn add react-native-push-notification<br />npx pod-install</code> | <code>npm install react-native-push-notification<br />npx pod-install</code> |

2. edit `android/build.gradle`

   ```
   ext {
       googlePlayServicesVersion = "<Your play services version>" // default: "+"
       firebaseMessagingVersion = "<Your Firebase version>" // default: "21.1.0"
   
       // Other settings
       compileSdkVersion = <Your compile SDK version> // default: 23
       buildToolsVersion = "<Your build tools version>" // default: "23.0.1"
       targetSdkVersion = <Your target SDK version> // default: 23
       supportLibVersion = "<Your support lib version>" // default: 23.1.1
   }
   ```

3. edit `android/app/src/main/AndroidManifest.xml`

   ```xml
       .....
       <uses-permission android:name="android.permission.VIBRATE" />
       <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
   
       <application ....>
           <!-- Change the value to true to enable pop-up for in foreground on receiving remote notifications (for prevent duplicating while showing local notifications set this to false) -->
           <meta-data  android:name="com.dieam.reactnativepushnotification.notification_foreground"
                       android:value="false"/>
           <!-- Change the resource name to your App's accent color - or any other color you want -->
           <meta-data  android:name="com.dieam.reactnativepushnotification.notification_color"
                       android:resource="@color/white"/> <!-- or @android:color/{name} to use a standard color -->
   
           <receiver android:name="com.dieam.reactnativepushnotification.modules.RNPushNotificationActions" />
           <receiver android:name="com.dieam.reactnativepushnotification.modules.RNPushNotificationPublisher" />
           <receiver android:name="com.dieam.reactnativepushnotification.modules.RNPushNotificationBootEventReceiver">
               <intent-filter>
                   <action android:name="android.intent.action.BOOT_COMPLETED" />
                   <action android:name="android.intent.action.QUICKBOOT_POWERON" />
                   <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
               </intent-filter>
           </receiver>
   
           <service
               android:name="com.dieam.reactnativepushnotification.modules.RNPushNotificationListenerService"
               android:exported="false" >
               <intent-filter>
                   <action android:name="com.google.firebase.MESSAGING_EVENT" />
               </intent-filter>
           </service>
        .....
   ```

### khusus iOS

link repo: https://github.com/react-native-push-notification/ios

## cara pake

### insiasi config

1. di `index.js`

   ```js
   import { Platform } from 'react-native';
   
   // push notification
   import PushNotification from "react-native-push-notification";
   
   PushNotification.configure({
       onNotification: (notification) => {
           console.log("NOTIFICATION:", notification);
       },
       requestPermissions: Platform.OS === "ios",
   });
   ```

2. di `App.js`

   1. buat channel dulu

      ```js
      // create channel
      const createChannel = () => {
        PushNotification.createChannel({
          channelId: "test-channel",
          channelName: "Test Channel",
        });
      }
      ```

   2. fungsi ini dibuat untuk membuat local notification

      ```js
      const handleNotification = () => {
        PushNotification.cancelAllLocalNotifications();
      
        PushNotification.localNotification({
          channelId: "test-channel",
          title: "Hello, world!",
          message: "You received this notification locally",
          bigText: "This is the big text of push notification. Lorem ipsum dolor sit amet."
        });
      }
      ```

   3. fungsi ini dibuat untuk membuat local notification bds jadwal (based on tanggal)

      ```js
      const handleNotification = () => {
          PushNotification.localNotificationSchedule({
            channelId: "test-channel",
            title: "Schedule notification",
            message: "This notification is scheduled 20 seconds ago",
            date: new Date(Date.now() + 20 * 1000),
            allowWhileIdle: true,
          })
        }

