// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CardModel {
  final String workSpaceId;
  final String ownerId;
  final String name;
  final List<Task> tasks;
  CardModel({
    required this.workSpaceId,
    required this.ownerId,
    required this.name,
    required this.tasks,
  });

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'workSpaceId': workSpaceId,
      'ownerId': ownerId,
      'name': name,
      'tasks': tasks.map((x) => x.toMap()).toList(),
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      tasks: [],
      workSpaceId: map['workSpaceId'] as String,
      ownerId: map['ownerId'] as String,
      name: map['name'] as String,
      // tasks:  List<Task>.from(map['tasks']?.map((x) => Task.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CardModel.fromJson(String source) =>
      CardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CardModel(workSpaceId: $workSpaceId, ownerId: $ownerId, name: $name)';

  @override
  bool operator ==(covariant CardModel other) {
    if (identical(this, other)) return true;

    return other.workSpaceId == workSpaceId &&
        other.ownerId == ownerId &&
        other.name == name;
  }

  @override
  int get hashCode => workSpaceId.hashCode ^ ownerId.hashCode ^ name.hashCode;
}

class Task {
  final String name;
  Task({
    required this.name,
  });

  Task copyWith({
    String? name,
  }) {
    return Task(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Task(name: $name)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
