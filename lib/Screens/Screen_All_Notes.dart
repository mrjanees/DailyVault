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
import '../Widgets/Note.dart';
import 'Screen_Add_Note.dart';
import 'Screen_Edit_Note.dart';
import '../note_model/note_model.dart';

const double VD_length = 0;

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
