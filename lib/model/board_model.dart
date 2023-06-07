// To parse this JSON data, do
//
//     final boardModel = boardModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BoardModel boardModelFromJson(String str) => BoardModel.fromJson(json.decode(str));

String boardModelToJson(BoardModel data) => json.encode(data.toJson());

class BoardModel {
    final String id;
    final String ownerId;
    final String name;
    final String background;
    final List<String> members;

    BoardModel({
        required this.id,
        required this.ownerId,
        required this.name,
        required this.background,
        required this.members,
    });

    factory BoardModel.fromJson(Map<String, dynamic> json) => BoardModel(
        id: json["id"],
        ownerId: json["ownerId"],
        name: json["name"],
        background: json["background"],
        members: List<String>.from(json["members"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ownerId": ownerId,
        "name": name,
        "background": background,
        "members": List<dynamic>.from(members.map((x) => x)),
    };
}
