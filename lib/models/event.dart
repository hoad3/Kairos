

class Event{
  int? id;
  String? title;
  String? note;
  int? isConpleted;
  String? date;
  String? starTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;


  Event({
    this.id,
    this.title,
    this.note,
    this.isConpleted,
    this.date,
    this.starTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat
});

  Event.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isConpleted = json['isConpleted'];
    date = json['date'];
    starTime = json['starTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['isConpleted'] = this.isConpleted;
    data['date'] = this.date;
    data['starTime'] = this.starTime;
    data['endTime'] = this.endTime;
    data['color'] = this.color;
    data['remind'] = this.remind;
    data['repeat'] = this.repeat;

    return data;
  }


}