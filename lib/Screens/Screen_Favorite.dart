import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../favorite_model/favorite_Model.dart';

ValueNotifier<List<FavModel>> FavListNotifier = ValueNotifier([]);

class ScreenFavorite extends StatelessWidget {
  const ScreenFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FavListNotifier,
      builder: (context, newvalue, child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final _data = newvalue[index];
              return ListTile(
                title: Text(_data.titile),
                subtitle: Text(_data.content),
                trailing: const Icon(Icons.delete),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: FavListNotifier.value.length);
      },
    );
  }
}
