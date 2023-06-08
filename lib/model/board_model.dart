// To parse this JSON data, do
//
//     final boardModel = boardModelFromJson(jsonString);

import 'dart:convert';
import 'package:trello_clone_appwrite/model/card_model.dart';

BoardModel boardModelFromJson(String str) =>
    BoardModel.fromJson(json.decode(str));

String boardModelToJson(BoardModel data) => json.encode(data.toJson());

class BoardModel {
  final String id;

  final String name;
  final String background;
  final List<CardModel> cards;

  BoardModel({
    required this.id,
    required this.name,
    required this.background,
    required this.cards,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) => BoardModel(
        id: json["id"],
        // ownerId: json["ownerId"],
        name: json["name"],
        background: json["background"],
        cards: List<CardModel>.from(
            json["cards"].map((x) => CardModel.fromJson(x))),
        // members: List<String>.from(json["members"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "ownerId": ownerId,
        "name": name,
        "background": background,
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
        // "members": List<dynamic>.from(members.map((x) => x)),
      };
}
