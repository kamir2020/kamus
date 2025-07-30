import 'dart:convert';

List<Word> wordFromJson(String str) => List<Word>.from(json.decode(str).map((x) => Word.fromJson(x)));

String wordToJson(List<Word> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Word {
  String id;
  String keyword1;
  String keyword2;
  String description;
  String audioName;

  Word({
    required this.id,
    required this.keyword1,
    required this.keyword2,
    required this.description,
    required this.audioName,
  });

  factory Word.fromJson(Map<String, dynamic> json) => Word(
    id: json["id"],
    keyword1: json["keyword1"],
    keyword2: json["keyword2"],
    description: json["description"],
    audioName: json["audioName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "keyword1": keyword1,
    "keyword2": keyword2,
    "description": description,
    "audioName": audioName,
  };
}