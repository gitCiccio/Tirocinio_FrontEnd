class Note{
  final String noteId;
  final String text;
  final DateTime dateNote;

  Note({required this.noteId, required this.text, required this.dateNote});

  factory Note.fromJson(Map<String, dynamic> json){
    return Note(
        noteId: json['noteId'],
        text: json['text'],
        dateNote: DateTime.parse(json['dateNote'])
    );
  }

  Map<String, dynamic>toJson(){
    return{
      'noteId': noteId,
      'text': text,
      'dateNote': dateNote.toIso8601String()
    };
  }
}