// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';


CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

final class CardModel {
  String workSpaceId;
  String ownerId;
  String name;
  List<Task> tasks;

  CardModel({
    required this.workSpaceId,
    required this.ownerId,
    required this.name,
    required this.tasks,
  });

  factory CardModel.fromJson(Map<String, dynamic> json,
          {bool isFromCard = false}) =>
      CardModel(
        workSpaceId: json["workSpaceId"],
        ownerId: json["ownerId"],
        name: json["name"],
        tasks: !isFromCard
            ? []
            : List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "workSpaceId": workSpaceId,
        "ownerId": ownerId,
        "name": name,
        "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
      };

  CardModel copyWith({
    String? workSpaceId,
    String? ownerId,
    String? name,
    List<Task>? tasks,
  }) {
    return CardModel(
      workSpaceId: workSpaceId ?? this.workSpaceId,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      tasks: tasks ?? this.tasks,
    );
  }
}

final class Task {
 final String  title;

  final String card_id;
  final String board_id;
  final bool? done;
  Task({
    required this.title,
    required this.card_id,
    required this.board_id,
    this.done=false,
  });


  Task copyWith({
    String? title,
    String? card_id,
    String? board_id,
    bool? done,
  }) {
    return Task(
      title: title ?? this.title,
      card_id: card_id ?? this.card_id,
      board_id: board_id ?? this.board_id,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'card_id': card_id,
      'board_id': board_id,
      'done': done,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      card_id: map['card_id'] as String,
      board_id: map['board_id'] as String,
      done: map['done'] != null ? map['done'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(title: $title, card_id: $card_id, board_id: $board_id, done: $done)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.card_id == card_id &&
      other.board_id == board_id &&
      other.done == done;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      card_id.hashCode ^
      board_id.hashCode ^
      done.hashCode;
  }
}
