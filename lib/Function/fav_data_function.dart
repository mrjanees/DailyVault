import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/Screens/Screen_All_Notes.dart';
import 'package:note_app/Screens/Screen_Favorite.dart';
import 'package:note_app/Provider/Fav_Icon/Fav_Icon.dart';
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
  Future<void> insertFavData(FavModel value) async {
    final data = await getFavData();

    data.forEach((element) {
      if (element.id == value.id) {
        _isexist = true;
      } else {
        _isexist = false;
      }
    });

    if (_isexist) {
      deleteFAvData(value.id);
      _isexist = false;
    } else {
      final element = await Hive.openBox<FavModel>(hiveKey);
      element.put(value.id, value);
      refreshUi();
    }
  }

  Future<bool> isexistfunction(String id) async {
    final data = await getFavData();
    print(data);
    data.forEach((element) {
      if (element.id == id) {
        _iconval = true;
      } else {
        _iconval = false;
      }
      notifyListeners();
    });

    print(_iconval);
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
