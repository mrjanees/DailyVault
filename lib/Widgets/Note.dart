import 'package:flutter/material.dart';
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
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Delete'),
                content: Text('Do you want to delete ?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        Data_fuctions.instance.Delete_all(id!);
                        FavFunction.instanse.deleteFAvData(id!);
                        Navigator.of(ctx).pop();
                      },
                      child: Text('Ok'))
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
              colors: context.watch<ThemeProvider>().Theme_note()),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.only(left: 5, top: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20,
              child: Row(
                children: [
                  Container(
                    width: 105,
                    child: Text(
                      title!,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () {
                        favSaveClick(title, content, id);
                      },
                      // ignore: unrelated_type_equality_checks
                      icon: context.watch<FavFunction>().isexistfunction(id!)
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border)),
                  const VerticalDivider(
                    width: 15,
                    color: Colors.white,
                    thickness: 1.5,
                    endIndent: 1,
                    indent: 1,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: 22,
                    onPressed: () {
                      Data_fuctions.instance.Delete_all(id!);
                      FavFunction.instanse.deleteFAvData(id!);
                    },
                    icon: const Icon(
                      Icons.cancel_rounded,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const Divider(
              thickness: 1.5,
              height: 2,
              indent: 1,
              endIndent: 7,
              color: Colors.white,
            ),
            Text(
              content!,
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 15,
              ),
              textAlign: TextAlign.start,
            )
          ],
        ),
      ),
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
