
import 'package:kairos/models/event.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io'; // Để kiểm tra nền tảng
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
class NotificationHelper{

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  static Future init()async{
    _configureLocalTimezone();
    requestAndroidPermissions();

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
      0,
      title,
      body,
      const NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id', // ID của kênh
        'your_channel_name', // Tên của kênh
        channelDescription: 'your_channel_description', // Mô tả
        importance: Importance.high, // Mức độ quan trọng
      ),
    ),
      // payload: 'Default_Sound',
  );
}
scheduledNotification(int hour, int minutes, Event event) async{
  try {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      event.id!.toInt(),
      event.title,
      event.note,
      _convertTime(hour, minutes),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              channelDescription: 'your channel description')),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    print('thong bao cho nguoi dung');
  } catch (e) {
    print('Lỗi khi gửi thông báo: $e');
  }

}
tz.TZDateTime _convertTime(int hour, int minutes)
{
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduleDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

  if(scheduleDate.isBefore(now))
    {
      scheduleDate = scheduleDate.add(const Duration(days:1));
    }

  return scheduleDate;
}

static Future<void> _configureLocalTimezone() async{
    tz.initializeTimeZones();
    final String timezone = await tz.local.name;
    tz.setLocalLocation(tz.getLocation(timezone));
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

}