import 'package:flutter/material.dart';
import 'package:kairos/db/db_helper.dart';
import 'package:kairos/services/notification_calendar.dart';
import 'package:kairos/services/themes_service.dart';
import 'package:kairos/ui/Calendar/Home_page.dart';
import 'package:kairos/ui/Calendar/themes.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';



void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await NotificationHelper.init();

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final CalendarController controller = CalendarController();

    return GetMaterialApp(
      title: 'Flutter Calendar',
      debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
      themeMode: ThemeService().theme,



      home: HomePage()
    );
  }
}

