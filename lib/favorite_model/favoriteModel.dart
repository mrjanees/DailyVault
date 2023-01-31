import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class FavModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String titile;

  @HiveField(2)
  String content;
  FavModel({required this.id, required this.titile, required this.content});
}
