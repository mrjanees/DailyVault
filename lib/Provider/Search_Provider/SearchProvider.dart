import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:note_app/Function/fav_data_function.dart';
import 'package:note_app/favorite_model/favoriteModel.dart';

class FavIconProVider with ChangeNotifier {
  bool _favicon = false;
  bool get favicon => _favicon;
  favIconchange() {
    _favicon = !_favicon;
    notifyListeners();
  }
}
