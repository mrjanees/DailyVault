import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_app/Function/URL.dart';
import 'package:note_app/note_model/note_model.dart';
import 'package:note_app/note_model_list/note_model_list.dart';

abstract class Data_calls {
  Future<void> GetAll();
  Future<void> create_all(NoteModel value);
  Future<void> Delete_all(String id);
  Future<void> updateAll(NoteModel value);
}

ValueNotifier<List<NoteModel>> noteNotifier = ValueNotifier([]);

class Data_fuctions extends Data_calls {
  Data_fuctions.internal();
  static Data_fuctions instance = Data_fuctions.internal();
  Data_fuctions factory() {
    return instance;
  }

  final dio = Dio();
  final url = Url();

  Data_fuctions() {
    dio.options = BaseOptions(
      baseUrl: url.baseUri,
      responseType: ResponseType.plain,
    );
  }

  @override
  Future<void> GetAll() async {
    final _response = await dio.get(
      url.baseUri + url.getNote,
    );
    print(_response);

    final getnoteRes = NoteModelList.fromJson(_response.data);

    noteNotifier.value.clear();

    noteNotifier.value.addAll(getnoteRes.data.reversed);
    noteNotifier.notifyListeners();
    ;
  }

  @override
  Future<void> create_all(NoteModel value) async {
    var Response = await dio.post(
      url.baseUri + url.createNote,
      data: value.toJson(),
    );
  }

  @override
  Future<void> Delete_all(String id) async {
    final result =
        await dio.delete(url.baseUri + url.deleteNote.replaceFirst("{id}", id));
    GetAll();
  }

  NoteModel? editNoteById(String id) {
    try {
      return noteNotifier.value.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateAll(NoteModel value) async {
    dio.put(url.baseUri + url.updateNote, data: value.toJson());

    final index =
        noteNotifier.value.indexWhere((value) => value.id == value.id);
    if (index == -1) {}
    noteNotifier.value.removeAt(index);
    noteNotifier.value.insert(index, value);
    noteNotifier.notifyListeners();
  }
}
