import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/Function/fav_data_function.dart';
import 'package:note_app/Provider/Fav_Icon/Fav_Icon.dart';
import 'package:note_app/favorite_model/favoriteModel.dart';
import 'package:provider/provider.dart';

import '../Provider/App_Color/App_theme.dart';
import '../Function/Note_Data_Calling.dart';
import 'Screen_Add_Note.dart';
import 'Screen_Edit_Note.dart';
import '../note_model/note_model.dart';

const double VD_length = 0;
bool isexist = false;

class ScreenAllNotes extends StatelessWidget {
  const ScreenAllNotes({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 10,
          right: 0,
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              child: Row(
                children: [
                  Text(
                    'All',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.Headline_Color()),
                  ),
                  const SizedBox(
                    width: 204,
                  ),
                  // IconButton(
                  //   color: themeProvider.Icon_color(),
                  //   onPressed: () {},
                  //   icon: FaIcon(FontAwesomeIcons.heart),
                  // ),
                  // const SizedBox(
                  //   width: VD_length,
                  // ),
                  // VerticalDivider(
                  //   color: themeProvider.Icon_color(),
                  //   endIndent: 10,
                  //   indent: 15,
                  //   width: 1, //width space of divider
                  //   thickness: 1.5, //thickness of divier line
                  // ),
                  const SizedBox(
                    width: VD_length,
                  ),
                  IconButton(
                    color: themeProvider.Icon_color(),
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                  const SizedBox(
                    width: VD_length,
                  ),
                  VerticalDivider(
                    color: themeProvider.Icon_color(),
                    endIndent: 10,
                    indent: 15,
                    width: 1, //width space of divider
                    thickness: 1.5, //thickness of divier line
                  ),
                  const SizedBox(
                    width: VD_length,
                  ),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      color: themeProvider.Icon_color(),
                      onPressed: () {
                        themeProvider.tooggleThemeData();
                      },
                      icon: themeProvider.IsLightTheme == true
                          ? Icon(Icons.light_mode)
                          : Icon(Icons.dark_mode)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notes',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.Headline_Color()),
                ),
                IconButton(
                    color: themeProvider.Icon_color(),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return ScreenAddnote();
                      }));
                    },
                    icon: const Icon(Icons.add_circle))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: ValueListenableBuilder(
              valueListenable: NoteNotifier,
              builder: (context, List<NoteModel> newValue, child) {
                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: List.generate(newValue.length, (index) {
                    final value = newValue[index];
                    if (value.id == null) {
                      const SizedBox();
                    }
                    return MyNote(
                      title: value.title,
                      content: value.content,
                      id: value.id,
                    );
                  }),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

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
                      icon: context.watch<FavFunction>().isexistfunction(id!) ==
                              true
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
