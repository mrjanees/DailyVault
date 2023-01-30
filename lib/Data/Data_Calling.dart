import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_app/Data/URL.dart';
import 'package:note_app/note_model/note_model.dart';
import 'package:note_app/note_model_list/note_model_list.dart';

abstract class Data_calls {
  Future<List<NoteModel>> Get_all();
  Future<NoteModel?> create_all(NoteModel value);
  Future<void> Delete_all(String id);
  Future<NoteModel?> update_all(NoteModel value);
}

class Data_fuctions extends Data_calls {
  Data_fuctions.internal();
  static Data_fuctions instance = Data_fuctions.internal();
  Data_fuctions factory() {
    return instance;
  }

  ValueNotifier<List<NoteModel>> NoteNotifier = ValueNotifier([]);

  final dio = Dio();
  final url = Url();

  Data_fuctions() {
    print('Constructor called');
    dio.options = BaseOptions(
      baseUrl: url.baseUri,
      responseType: ResponseType.plain,
    );
  }

  @override
  Future<List<NoteModel>> Get_all() async {
    final _response = await dio.get(
      url.baseUri + url.getNote,
    );

    final getnoteRes = NoteModelList.fromJson(_response.data);
    NoteNotifier.value.clear();
    NoteNotifier.value.addAll(getnoteRes.data.reversed);
    NoteNotifier.notifyListeners();
    return getnoteRes.data;
  }

  @override
  Future<NoteModel?> create_all(NoteModel value) async {
    var Response = await dio.post(
      url.baseUri + url.createNote,
      data: value.toJson(),
    );
    final dataAsjson = jsonDecode(Response.data);
    return NoteModel.fromJson(dataAsjson as Map<String, dynamic>);
  }

  @override
  Future<void> Delete_all(String id) async {
    final result =
        await dio.delete(url.baseUri + url.deleteNote.replaceFirst("{id}", id));
    Get_all();
  }

  NoteModel? EditNoteBy_id(String id) {
    try {
      return NoteNotifier.value.firstWhere((note) => note.id == id);
    } catch (e) {
      print('Note found Id');
      return null;
    }
  }

  @override
  Future<NoteModel?> update_all(NoteModel editValue) async {
    final EditResponse =
        dio.put(url.baseUri + url.updateNote, data: editValue.toJson());
    if (EditResponse == null) {
      print('EditNote is null');
    } else {
      final index =
          NoteNotifier.value.indexWhere((value) => value.id == editValue.id);
      if (index == -1) {
        print("Note found id");
      }
      NoteNotifier.value.removeAt(index);
      NoteNotifier.value.insert(index, editValue);
      NoteNotifier.notifyListeners();
    }
  }
}
