import 'package:hive_flutter/hive_flutter.dart';
part 'favoriteModel.g.dart';

@HiveType(typeId: 1)
class FavModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  FavModel({required this.id, required this.title, required this.content});
  @override
  String toString() {
    // TODO: implement toString
    return 'id : ${id} , title : ${title} content : ${content}';
  }
}
