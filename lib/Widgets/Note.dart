import 'package:flutter/material.dart';
import 'package:note_app/Provider/Search_Provider/SearchProvider.dart';
import 'package:note_app/Screens/Screen_Favorite.dart';
import 'package:provider/provider.dart';

import '../Function/Note_Data_Calling.dart';
import '../Function/fav_data_function.dart';
import '../Provider/App_Color/App_theme.dart';
import '../Screens/Screen_Edit_Note.dart';
import '../favorite_model/favoriteModel.dart';

class MyNote extends StatelessWidget {
  final String? id;
  final String? title;
  final String? content;
  MyNote({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ThemeProvider themeProvider =
            Provider.of<ThemeProvider>(context, listen: false);
        final favIconProvider =
            Provider.of<FavFunction>(context, listen: false);
      },
    );
    // ValueNotifier<bool> FavIcon = ValueNotifier(false);
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor:
                          context.watch<ThemeProvider>().Inside_Text_color(),
                      // icon: Icon(
                      //   Icons.delete,
                      //   color: context.watch<ThemeProvider>().Inside_Text_color(),
                      // ),
                      title: Text(
                        'Delete',
                        style: TextStyle(
                            color: context
                                .watch<ThemeProvider>()
                                .Headline_Color()),
                      ),
                      content: Text(
                        'Do you want to delete ?',
                        style: TextStyle(
                            color: context
                                .watch<ThemeProvider>()
                                .Headline_Color()),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: context
                                      .watch<ThemeProvider>()
                                      .Headline_Color()),
                            )),
                        TextButton(
                            onPressed: () {
                              Data_fuctions.instance.Delete_all(id!);
                              FavFunction.instanse.deleteFAvData(id!);
                              Navigator.of(ctx).pop();
                            },
                            child: Text(
                              'Ok',
                              style: TextStyle(
                                  color: context
                                      .watch<ThemeProvider>()
                                      .Headline_Color()),
                            ))
                      ],
                    );
                  });
            },
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    return ScreenEditNote(
                      id: id,
                    );
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: context.watch<ThemeProvider>().Theme_note(),
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.only(top: 5, left: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 138,
                        child: Text(
                          title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          iconSize: 22,
                          color: Colors.white,
                          onPressed: () {
                            favSaveClick(title, content, id);
                          },
                          // ignore: unrelated_type_equality_checks
                          icon:
                              context.watch<FavFunction>().isexistfunction(id!)
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border)),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                    indent: 1,
                    endIndent: 7,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Expanded(
                    child: Text(
                      content!,
                      maxLines: 8,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  favSaveClick(title, content, id) {
    // print(id);
    // print(title);
    // print(content);
    final titledata = title;
    final contentData = content;
    if (titledata.isEmpty || contentData.isEmpty) {}
    final data = FavModel(content: contentData, title: titledata, id: id);
    FavFunction.instanse.insertFavData(data);
  }
}
