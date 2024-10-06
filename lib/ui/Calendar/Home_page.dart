

// import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kairos/Controller/event_controller.dart';
import 'package:kairos/models/event.dart';
import 'package:kairos/services/notification_calendar.dart';
import 'package:kairos/services/themes_service.dart';
import 'package:get/get.dart';
import 'package:kairos/ui/Calendar/add_task_bar.dart';
import 'package:kairos/ui/Calendar/themes.dart';
import 'package:kairos/ui/widgets/Event_Tile.dart';
import 'package:kairos/ui/widgets/button_create.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kairos/ui/widgets/button_create_note.dart';
import 'package:kairos/ui/widgets/noteScreen.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();


  
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;
  late NotificationHelper notificationHelper;
  DateTime _selectedDate = DateTime.now();
  final _evenController = Get.put(EventController());

  @override
  void initState() {
    super.initState();
    NotificationHelper.requestAndroidPermissions();
    notificationHelper = NotificationHelper();
    _evenController.getEvent();

    // Khởi tạo timer để kiểm tra thời gian sự kiện
    _timer = Timer(Duration(seconds: 2), () {
      _checkEvents();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Dừng timer khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.primaryColor,

      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(height: 10,),
          _showEvent()

        ],
      ),
      
    );
  }
  _showEvent(){
     return Expanded(
      child: Obx((){
        return ListView.builder(
          itemCount: _evenController.eventList.length,
          itemBuilder: (_, index){
            // print(_evenController.eventList.length);
            Event event = _evenController.eventList[index];
            DateTime now = DateTime.now();

            String formattedNow = DateFormat.jm().format(now); // Định dạng thời gian của now
            String cleanFormattedNow = formattedNow.replaceAll(RegExp(r'\s+'), '');
            String cleanEventStarTime = (event.starTime ?? '').replaceAll(RegExp(r'\s+'), '').replaceAll(RegExp(r'^0+'), '');
            // Tách giờ và phút
            List<String> eventTimeParts = cleanEventStarTime.split(":");
            if (eventTimeParts.length == 2) {
              // int hour = int.parse(eventTimeParts[0].replaceAll(RegExp(r'[^0-9]'), '')); // Lọc các ký tự không phải số
              // int minute = int.parse(eventTimeParts[1].replaceAll(RegExp(r'[^0-9]'), ''));

              // So sánh thời gian đã được làm sạch
              if (cleanFormattedNow.trim().toLowerCase() == cleanEventStarTime.trim().toLowerCase()) {

                // print(cleanFormattedNow);
                // print(cleanEventStarTime);
                //
                // // Thực hiện thông báo
                //
                // print('Gọi hàm scheduledNotification với hour: $hour, minute: $minute');
                // // notificationHelper.scheduledNotification(hour, minute, event);
                // _sendSimpleNotification(event);



              }
            } else {
              print('Thời gian không hợp lệ: $cleanEventStarTime');
            }
            if(cleanFormattedNow.trim().toLowerCase() == cleanEventStarTime.trim().toLowerCase()){
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            // print("tapped");
                            _showBottomSheet(context, event);
                          },
                          child: EventTile(event: event),
                        )
                      ],
                    ),
                  )
              );

          }
            if(event.date==DateFormat.yMd().format(_selectedDate))
              {
                // DateTime now = DateTime.now();
                // String formattedNow = DateFormat.jm().format(now); // Định dạng thời gian của now
                // // Loại bỏ tất cả các ký tự trắng
                // String cleanFormattedNow = formattedNow.replaceAll(RegExp(r'\s+'), '');
                // String cleanEventStarTime = (event.starTime ?? '').replaceAll(RegExp(r'\s+'), '').replaceAll(RegExp(r'^0+'), '');
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){

                              _showBottomSheet(context, event);
                            },
                            child: EventTile(event: event),
                          )
                        ],
                      ),
                    ));
              }
            else
              {
                return Container();
              }

          });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Event event) async
  {
    await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: event.isConpleted==1?
            MediaQuery.of(context).size.height*0.24:
            MediaQuery.of(context).size.height*0.32,
            color: Get.isDarkMode?darkGreyClr:Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
              ),
            ),
            const Spacer(),
            event.isConpleted == 1?Container(): _buttomSheetButton(
              label: "Event completed",
              onTap: (){
                _evenController.eventCompleted(event.id!);
                _evenController.getEvent();
                Get.back();
                // print('asaaaaaaaaaaaaaaaaaaaaaaa'+ '${event.isConpleted}');

              },
              clr: primaryClr,
              context: context,
            ),
            _buttomSheetButton(
              label: "Event delete",
              onTap: (){
                _evenController.deleteEvent(event);
                _evenController.getEvent();
                Get.back();

              },
              clr: Colors.red[300]!,
              context: context,
            ),
          _buttomSheetButton(
            label: "Close",
            onTap: (){
              Get.back();

            },
            clr: Colors.red,
            isClose: true,
            context: context,
          ),

        ]

        ),
      ),
    );
  }
  _buttomSheetButton({required String label, required Function()? onTap, required Color clr, bool isClose = false, required BuildContext context}){
      return GestureDetector(
        onTap: onTap,
        child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
          height: 55,
          width: MediaQuery.of(context).size.width*1.2,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: isClose==true ? Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr,
            ),
            color: isClose ==true ? Colors.transparent:clr,
            borderRadius: BorderRadius.circular(20),

          ),
          child: Center(
            child: Text(
              label,
              style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
            ),
          ),

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
          setState(() {
            _selectedDate = date;
          });
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
          ButtonCreateNote(label: "Notepad", onTap: ()async{
              await Get.to(() => noteScreen());
        },
      ),
          Button_Create_Event(label: "+ Add Event", onTap: () async{
                   await Get.to(() => AddTaskBar());
                   _evenController.getEvent();
            }
          )
        ],
      ),
    );

  }

  void _checkEvents() {
    DateTime now = DateTime.now();
    String formattedNow = DateFormat.jm().format(now).replaceAll(RegExp(r'\s+'), '');

    for (Event event in _evenController.eventList) {
      String cleanEventStarTime = (event.starTime ?? '').replaceAll(RegExp(r'\s+'), '').replaceAll(RegExp(r'^0+'), '');

      // Nếu thời gian hiện tại khớp với thời gian bắt đầu sự kiện
      if (formattedNow.trim().toLowerCase() == cleanEventStarTime.trim().toLowerCase()) {
        _sendSimpleNotification(event); // Gửi thông báo
        break; // Chỉ gửi thông báo một lần cho mỗi sự kiện
      }
    }
  }

  Future<void> _sendSimpleNotification(Event event) async {
    String title = "Thông báo sự kiện"; // Tiêu đề thông báo
    String body = "Sự kiện ${event.title} đã bắt đầu"; // Nội dung thông báo
    String payload = "data"; // Dữ liệu bổ sung (nếu cần)

    try {
      await NotificationHelper.showsimplenotification(
        title: title,
        body: body,
        payload: payload,
      );
    } catch (e) {
      print('Lỗi khi gửi thông báo: $e');
    }
  }

  _appBar(){
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      leading: GestureDetector(
        onTap: () async{
          ThemeService().SwitchTheme();
         await  NotificationHelper.showsimplenotification(title: "Chuyển chế độ", body: "", payload: "data");
        },
        child: Icon(Get.isDarkMode ?Icons.wb_sunny_outlined:Icons.nightlight_round,
          size: 30,
        color: Get.isDarkMode ? Colors.white:Colors.black,
        ),
      ),
      actions: [
        Icon(Icons.supervised_user_circle_outlined),
        SizedBox(width: 30,),
      ],
    );
  }
}



