# cara push notification ios

btw itu lanjutan dari [nomor 4](4-push-notification-firebase-2.md)

## persiapan

1. buat project Firebase
2. klik **Project Settings** -> **Add app** -> **iOS**
   1. tulis iOS bundle (pastikan di **XCode** badign **bundle identifier** dan **ios bundle id** di firebase sama), lalu **Next**
   2. download **GoogleService-info.plist**, taro di folder **NamaProject/NamaProject** (misalnya, **CardGame/CardGame** untuk nama project **CardGame**)
   3. tambah firebase SDK (pokoknya ikutin instruksi di situ aja)
   4. tambah kode iniasialisasi di **AppDelegate** (copy aja kodenya)
   5. udah deh

3. ikutin instruksi di https://rnfirebase.io