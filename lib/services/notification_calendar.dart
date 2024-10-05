
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io'; // Để kiểm tra nền tảng

class NotificationHelper{

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  static Future init()async{
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => null);
    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
        defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) => null);
  }

static Future showsimplenotification({
    required String title,
    required String body,
    required String payload,
})async{
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await _flutterLocalNotificationsPlugin.show(
      0, 'plain title', 'plain body', notificationDetails,
      payload: 'item x');
}
  static Future<void> requestAndroidPermissions() async {
    if (Platform.isAndroid) {
      // Kiểm tra quyền thông báo
      var status = await Permission.notification.status;
      if (!status.isGranted) {
        // Nếu chưa được cấp, yêu cầu quyền
        PermissionStatus permissionStatus = await Permission.notification.request();
        if (permissionStatus.isGranted) {
          print("Quyền thông báo đã được cấp.");
        } else {
          print("Quyền thông báo bị từ chối.");
        }
      }
    }
  }

  //   FlutterLocalNotificationsPlugin
//   flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin(); //
//
//   initializeNotification() async {
//     // Cấu hình cho iOS
//     final DarwinInitializationSettings initializationSettingsIOS =
//     DarwinInitializationSettings(
//         requestSoundPermission: false,
//         requestBadgePermission: false,
//         requestAlertPermission: false,
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification
//     );
//
//     // Cấu hình cho Android
//     final AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings("appicon");
//
//     // Cấu hình chung
//     final InitializationSettings initializationSettings =
//     InitializationSettings(
//       iOS: initializationSettingsIOS,
//       android: initializationSettingsAndroid,
//     );
//
//     // Khởi tạo thông báo cục bộ với hàm callback `onSelectNotification`
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: selectNotification, // Callback cho cả Android và iOS
//     );
//   }
//
// // Hàm callback được gọi khi người dùng nhấn vào thông báo (Android và iOS)
//   Future selectNotification(NotificationResponse notificationResponse) async {
//     if (notificationResponse.payload != null) {
//       print('Thông báo có payload: ${notificationResponse.payload}');
//       // Thực hiện hành động khi người dùng nhấn vào thông báo
//     } else {
//       print('Không có payload');
//     }
//     Get.to(() => Container(color: Colors.white,));
//   }
//
// // Hàm này chỉ dành cho iOS, không dùng trên Android
//   Future onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // Xử lý khi nhận thông báo trên iOS khi ứng dụng đang ở foreground
//     print("Nhận thông báo trên iOS: $title");
//   }
//
//   void requestAndroidPermissions() async {
//     if (Platform.isAndroid) {
//       print("Quyền thông báo không được cấp.");
//       // Kiểm tra nếu phiên bản Android >= 13 (API 33)
//       if (await _isAndroid13OrAbove()) {
//         var status = await Permission.notification.status;
//         if (!status.isGranted) {
//           // Nếu quyền chưa được cấp, yêu cầu quyền từ người dùng
//           PermissionStatus permissionStatus = await Permission.notification.request();
//           if (permissionStatus.isGranted) {
//             print("Quyền thông báo đã được cấp.");
//           } else {
//             print("Quyền thông báo bị từ chối.");
//           }
//         } else {
//           print("Quyền thông báo đã được cấp trước đó.");
//         }
//       } else {
//         // Nếu Android dưới 13, quyền thông báo mặc định được cấp
//         print("Không cần yêu cầu quyền thông báo cho Android dưới phiên bản 13.");
//       }
//     }
//   }
//
//   Future<bool> _isAndroid13OrAbove() async {
//     // Kiểm tra phiên bản Android
//     int sdkInt = await _getSdkInt();
//     return sdkInt >= 33; // API 33 tương ứng với Android 13
//   }
//
//   Future<int> _getSdkInt() async {
//     // Sử dụng `platform_channel` để lấy thông tin SDK nếu cần
//     return int.parse(Platform.operatingSystemVersion.split(" ")[1].split("-")[0]);
//   }
//
//   void showNotification() async {
//     print('da chay ham nay ');
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your_channel_id', // ID kênh thông báo
//       'your_channel_name', // Tên kênh
//       //'your_channel_description', // Mô tả kênh
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );
//     print('da chay ham nay ');
//     var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//     print('da chay ham nay ');
//     await flutterLocalNotificationsPlugin.show(
//       0, // ID thông báo
//       'Tiêu đề thông báo', // Tiêu đề thông báo
//       'Nội dung thông báo', // Nội dung thông báo
//       platformChannelSpecifics,
//       payload: 'Thông tin thêm nếu cần', // Payload để xử lý khi nhấn vào thông báo
//     );
//   }
}