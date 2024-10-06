import 'package:get/get.dart';
import 'package:kairos/db/db_helper.dart';
import 'package:kairos/models/event.dart';

class EventController extends GetxController
{
    @override
    void onReady(){
      super.onReady();
    }

    var eventList = <Event>[].obs;

    Future<int> addEvent({Event? event}) async
    {
      return await DBHelper.insert(event);
    }

    void getEvent() async
    {
      List<Map<String, dynamic>> events = await DBHelper.query();
      eventList.assignAll(events.map((data)=> new Event.fromJson(data)).toList());
    }

    void deleteEvent(Event event) async{
     await DBHelper.deleteEventDb(event);

    }

    void eventCompleted(int id) async{
      await DBHelper.updateEvent(id);
    }
}