import 'package:flutter/material.dart';
// import 'package:kairos/screens/widgets/noteScreen.dart';
import 'package:kairos/services/notification_calendar.dart';
import 'package:kairos/services/themes_service.dart';
import 'package:kairos/ui/Calendar/Home_page.dart';
import 'package:kairos/ui/Calendar/themes.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';



void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
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

