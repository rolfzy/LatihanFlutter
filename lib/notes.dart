class Note {
  final int? id;
  final String title;
  bool isCompleted;

  Note({this.id, required this.title, this.isCompleted = false});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
    );
  }
  Map<String, dynamic> toJson(){
    return{
      'id':id,
      'title':title,
      'isCompleted':isCompleted,
    };
  }
}