


import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kairos/services/notification_calendar.dart';
import 'package:kairos/services/themes_service.dart';
import 'package:get/get.dart';
import 'package:kairos/ui/Calendar/add_task_bar.dart';
import 'package:kairos/ui/Calendar/themes.dart';
import 'package:kairos/ui/widgets/button_create.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();


  
}

class _HomePageState extends State<HomePage> {
  late NotificationHelper notificationHelper;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    NotificationHelper.requestAndroidPermissions();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),

      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar()

        ],
      ),
      
    );
  }
  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            )
        ),
        dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            )
        ),
        monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            )
        ),
        onDateChange: (date){
          _selectedDate = date;
        },
      ),
    );
  }
  _addTaskBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text("Today",
                  style: headingStyle,
                ),

              ],
            ),
          ),
          Button_Create_Event(label: "+ Add Event", onTap: () => Get.to(()=> AddTaskBar()),
          )
        ],
      ),
    );

  }
  _appBar(){
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      leading: GestureDetector(
        onTap: (){
          ThemeService().SwitchTheme();
          NotificationHelper.showsimplenotification(title: "simple notification", body: "ditconme metvcl", payload: "data");
        },
        child: Icon(Get.isDarkMode ?Icons.wb_sunny_outlined:Icons.nightlight_round,
          size: 20,
        color: Get.isDarkMode ? Colors.white:Colors.black,
        ),
      ),
      actions: [
        Icon(Icons.supervised_user_circle_outlined),
        SizedBox(width: 20,),
      ],
    );
  }
}



