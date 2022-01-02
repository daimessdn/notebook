# cara push notification ke react native pake firebase

## instalasi

1. install `react-native-push-notification` (seperti sebelumnya)
2. tambahkan class path di `build.gradle`

```
buildscript {
    ...
    dependencies {
        ...
        classpath('com.google.gms:google-services:4.3.3') // tambah ini
        ...
    }
}
```

3. di `android/app/build.gradle`

   ```
   dependencies {
     ...
     implementation 'com.google.firebase:firebase-analytics:17.3.0'  // tambah yang ini
     ...
   }
   
   apply plugin: 'com.google.gms.google-services' // tambah yang ini
   ```

4. simpan atawa copy `google-settings.json` ke `android/app`

5. clean cache dari gradlew (sync Gradle)

   ```bash
   cd android
   ./gradlew clean
   ```

6. jalanin aplikasi

   ```bash
   yarn android
   ```

## di firebase

1. buka console firebase, trus pilih menu **Cloud Messaging**, klik **Send your first message**
2. Masukkan title notifikasi, tulis pesan notifikasi, tambahkan gambar/ikon (jika perlu), klik **Next**
3. pilih target aplikasi, lalu **Next**
4. di bagian **Scheduling**, pilih jadwal, lalu **Next**
5. (optional), setup notification channel, lalu **Review**
6. setelah dirasa sesuai, klik **Publish**
7. Nanti akan muncul notifikasi sesuai dengan yang diisi.

