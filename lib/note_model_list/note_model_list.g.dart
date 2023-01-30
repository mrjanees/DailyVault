// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModelList _$NoteModelListFromJson(Map<String, dynamic> json) =>
    NoteModelList(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NoteModelListToJson(NoteModelList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
