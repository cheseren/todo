// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) {
  return TodoModel(
    todoId: json['todoId'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    dateCreated: json['dateCreated'] as num?,
    dateAccomplished: json['dateAccomplished'] as num?,
  );
}

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'todoId': instance.todoId,
      'name': instance.name,
      'description': instance.description,
      'dateCreated': instance.dateCreated,
      'dateAccomplished': instance.dateAccomplished,
    };
