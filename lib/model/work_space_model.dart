// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:trello_clone_appwrite/model/board_model.dart';

class WorkSpaceModel {
  final String ownerId;
  final String name;
  final List<String> members;
  final List<BoardModel> board;
  WorkSpaceModel({
    required this.ownerId,
    required this.name,
    required this.members,
    required this.board,
  });

  WorkSpaceModel copyWith({
    String? ownerId,
    String? name,
    List<String>? members,
    List<BoardModel>? board,
  }) {
    return WorkSpaceModel(
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      members: members ?? this.members,
      board: board ?? this.board,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': ownerId,
      'name': name,
      'members': List<dynamic>.from(members.map((x) => x)),
    };
  }

  factory WorkSpaceModel.fromJson(Map<String, dynamic> json) => WorkSpaceModel(
        ownerId: json["ownerId"],
        name: json["name"],
        members: [],
        board: List<BoardModel>.from(
            json["board"].map((x) => BoardModel.fromJson(x))),
      );

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'WorkSpaceModel(id: $ownerId, name: $name, members: $members)';

  @override
  bool operator ==(covariant WorkSpaceModel other) {
    if (identical(this, other)) return true;

    return other.ownerId == ownerId &&
        other.name == name &&
        listEquals(other.members, members);
  }

  @override
  int get hashCode => ownerId.hashCode ^ name.hashCode ^ members.hashCode;
}
