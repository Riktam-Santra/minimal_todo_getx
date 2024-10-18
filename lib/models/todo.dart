import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Todo {
  int id;
  String title;
  String? subtitle;
  bool? completed;
  Todo(this.id, this.title, this.subtitle, {this.completed = false});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        json['id'] ?? 0,
        json['title'] ?? '',
        json['subtitle'],
        completed: json['completed'],
      );

  toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'completed': completed,
      };
}
