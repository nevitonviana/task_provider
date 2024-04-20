import 'dart:convert';

class TaskModel {
  final int id;
  final String description;
  final DateTime dateTime;
  final bool finished;

  TaskModel({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.finished,
  });

  factory TaskModel.loadFormBD(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id']?.toInt(),
      description: map['descricao'],
      dateTime: DateTime.parse(map['data_hora']),
      finished: map['finalizado'] == 1,
    );
  }
}
