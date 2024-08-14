
class Note{
  final String title;
  final String body;

  Note({required this.title,required this.body});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      body: json['body'],
    );
  }
}