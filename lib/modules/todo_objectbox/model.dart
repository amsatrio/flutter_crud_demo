import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {
  @Id()
  int? id;
  final String title;
  final bool completed;

  Todo({this.id, required this.title, this.completed = false});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'],
        title: json['title'],
        completed: json['completed'],
      );

  Map<String, dynamic> toJson() => {'title': title, 'completed': completed};

  Todo copyWith({int? id, String? title, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}