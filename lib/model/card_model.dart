// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
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

class Task {
  String name;

  Task({
    required this.name,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  Task copyWith({
    String? name,
  }) {
    return Task(
      name: name ?? this.name,
    );
  }
}
