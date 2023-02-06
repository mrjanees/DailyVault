import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:note_app/Function/fav_data_function.dart';
import 'package:note_app/Provider/App_Color/App_theme.dart';
import 'package:note_app/Provider/App_Color/color_constant.dart';
import 'package:provider/provider.dart';

import '../favorite_model/favoriteModel.dart';

ValueNotifier<List<FavModel>> favListNotifier = ValueNotifier([]);

class ScreenFavorite extends StatelessWidget {
  const ScreenFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeprovider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 5,
        right: 5,
      ),
      child: Column(
        children: [
          Row(children: [
            Text(
              'Fav',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: themeprovider.Headline_Color()),
            ),
          ]),
          Row(
            children: [
              Text(
                'Notes',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: themeprovider.Headline_Color()),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: favListNotifier,
              builder: (context, newvalue, child) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      final data = newvalue[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: themeprovider.Theme_note())),
                          child: ListTile(
                            title: Text(
                              data.title,
                              style: const TextStyle(
                                  color: App_colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data.content,
                              style: const TextStyle(color: App_colors.white),
                            ),
                            trailing: IconButton(
                              color: App_colors.white,
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                FavFunction().deleteFAvData(data.id);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: favListNotifier.value.length);
              },
            ),
          ),
        ],
      ),
    );
  }
}
