import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/Screens/Screen_All_Notes.dart';
import 'package:note_app/Screens/Screen_Favorite.dart';

import 'package:note_app/favorite_model/favoriteModel.dart';
import 'package:provider/provider.dart';

abstract class FavDataCalling {
  Future<List<FavModel>> getFavData();
  Future<void> insertFavData(FavModel value);
  Future<void> deleteFAvData(String id);
}

class FavFunction extends ChangeNotifier implements FavDataCalling {
  bool _isexist = false;

  String hiveKey = 'Hive_key';
  bool _iconval = false;
  bool get iconval => _iconval;

  FavFunction._internal();
  static FavFunction instanse = FavFunction._internal();
  factory FavFunction() {
    return instanse;
  }

  @override
  Future<List<FavModel>> getFavData() async {
    final data = await Hive.openBox<FavModel>(hiveKey);
    return data.values.toList();
  }

  @override
  Future<bool> insertFavData(FavModel value) async {
    final data = favListNotifier.value;
    var contain = data.where((element) => element.id == value.id);
    if (contain.isEmpty) {
      final element = await Hive.openBox<FavModel>(hiveKey);
      element.put(value.id, value);

      notifyListeners();
      refreshUi();
    } else {
      notifyListeners();
      deleteFAvData(value.id);
    }
    return iconval;
  }

  bool isexistfunction(String id) {
    final data = favListNotifier.value;

    var contain = data.where((element) => element.id == id);
    if (contain.isEmpty) {
      _iconval = false;
    } else {
      _iconval = true;
    }
    return iconval;
  }

  refreshUi() async {
    final data = await getFavData();
    favListNotifier.value.clear();
    favListNotifier.value.addAll(data.reversed);
    favListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteFAvData(String id) async {
    final data = await Hive.openBox<FavModel>(hiveKey);
    data.delete(id);
    refreshUi();
  }
}
