import 'package:json_annotation/json_annotation.dart';
import 'package:note_app/note_model/note_model.dart';

part 'note_model_list.g.dart';

@JsonSerializable()
class NoteModelList {
  @JsonKey(name: 'data')
  List<NoteModel> data;

  NoteModelList({this.data = const []});

  factory NoteModelList.fromJson(Map<String, dynamic> json) {
    return _$NoteModelListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NoteModelListToJson(this);
}
