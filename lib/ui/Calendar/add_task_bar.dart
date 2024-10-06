
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kairos/Controller/event_controller.dart';
import 'package:kairos/models/event.dart';
import 'package:kairos/ui/Calendar/themes.dart';
import 'package:kairos/ui/widgets/button_create_1.dart';
import 'package:kairos/ui/widgets/input_field_event.dart';

class AddTaskBar extends StatefulWidget {
  const AddTaskBar({super.key});

  @override
  State<AddTaskBar> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddTaskBar> {
  final EventController _eventController = Get.put(EventController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _starTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "10:30 PM";
  int _selectedRemind = 5;
  List<int> remindList=[5,10,15,20,];
  String _selectedRepeat = "None";
  List<String> selectedRepeat=["None","Daily","Weekly","Monthly",];
  int _selectedColor=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Event",
                style: headingStyle,
              ),
              InputFieldEvent(title: "Title" , hint: "Enter your title Event", controller: _titleController,),
              InputFieldEvent(title: "Note" , hint: "Enter your note Event", controller: _noteController,),
              InputFieldEvent(title: "Date" , hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined,
                  color: Colors.grey,
                  ),
                  onPressed: (){
                    _getDateFromUser();

                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputFieldEvent(
                        title: "Star Time",
                        hint: _starTime,
                        widget: IconButton(
                            onPressed: (){
                              _getTimeFromUser(isStarTime: true);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            )),
                    ),
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: InputFieldEvent(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                          onPressed: (){
                              _getTimeFromUser(isStarTime: false);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          )),
                    ),
                  ),

                ],
              ),
              InputFieldEvent(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton<int>(
                  value: _selectedRemind, // Đặt giá trị hiện tại
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  iconSize: 32,
                  elevation: 4,
                  style: dropDownStyle,
                  underline: Container(),
                  items: remindList.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(), // Chuyển đổi danh sách thành List<DropdownMenuItem<String>>
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedRemind = newValue!; // Cập nhật giá trị khi người dùng chọn
                    });
                  },
                ),
              ),
              // InputFieldEvent(
              //   title: "Repeat",
              //   hint: "$_selectedRepeat",
              //   widget: DropdownButton<String>(
              //     value: _selectedRepeat, // Đặt giá trị hiện tại
              //     icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              //     iconSize: 32,
              //     elevation: 4,
              //     style: dropDownStyle,
              //     underline: Container(),
              //     items: selectedRepeat.map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value.toString(), style: TextStyle(color: Colors.grey),),
              //       );
              //     }).toList(), // Chuyển đổi danh sách thành List<DropdownMenuItem<String>>
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         _selectedRepeat = newValue!; // Cập nhật giá trị khi người dùng chọn
              //       });
              //     },
              //   ),
              // ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    _colorPalete(),
                  ButtonCreate1(label: "Create Event", onTap: () => _validateDate())
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  _validateDate(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty)
      {
        _addEventToDb();
        Get.back();
      }else if(_titleController.text.isEmpty||_noteController.text.isEmpty)
        {
          Get.snackbar("Required", "All fiel are require",
          snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.pink,
            icon: Icon(Icons.warning_amber_rounded,
            color: Colors.red,
            )
          );

        }
  }

  _addEventToDb() async{
   int value = await _eventController.addEvent(
        event: Event(
          note: _noteController.text,
          title: _titleController.text,
          date: DateFormat.yMd().format(_selectedDate),
          starTime: _starTime,
          endTime: _endTime,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
          color: _selectedColor,
          isConpleted: 0,
        )
    );
   // print("my event"+"$value" );
  }

  _colorPalete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",
          style: titleStyle,
        ),
        SizedBox(height: 8.0,),
        Wrap(
          children: List<Widget>.generate(
              3,
                  (int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index == 0 ? primaryClr : index == 1
                          ? redClr
                          : orangeClr,
                      child: _selectedColor == index ? Icon(Icons.done,
                        color: Colors.white,
                        size: 16,
                      ) : Container(),
                    ),
                  ),
                );
              }
          ),

        )
      ],
    );
  }
  _appBar(BuildContext context){
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      leading: GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
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
  _getDateFromUser() async
  {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2016),
        lastDate: DateTime(2121)
    );

    if(_pickerDate!=null)
      {
        setState(() {
          _selectedDate = _pickerDate;
          print(_selectedDate);
        });
      }else{

    }
  }
  _getTimeFromUser({required bool isStarTime}) async{
      var pickerTime = await _showTimePiker();
      if(pickerTime != null)
        {
          String _formatedTime = pickerTime.format(context); // Định dạng thời gian
          if (isStarTime) {
            setState(() {
              _starTime = _formatedTime; // Cập nhật thời gian bắt đầu
            });
          } else {
            setState(() {
              _endTime = _formatedTime; // Cập nhật thời gian kết thúc
            });
          }
        } else {
       // Nếu không có thời gian nào được chọn
      }
  }
  _showTimePiker() async{
    return await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_starTime.split(":")[0]),
          minute: int.parse(_starTime.split(":")[1].split(" ")[0])
      ),
    );
  }

}


