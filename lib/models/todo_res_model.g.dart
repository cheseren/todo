// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoResponseModel _$TodoResponseModelFromJson(Map<String, dynamic> json) {
  return TodoResponseModel(
    hasNextPage: json['hasNextPage'] as bool?,
    docs: (json['docs'] as List<dynamic>?)
        ?.map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TodoResponseModelToJson(TodoResponseModel instance) =>
    <String, dynamic>{
      'hasNextPage': instance.hasNextPage,
      'docs': instance.docs,
    };
