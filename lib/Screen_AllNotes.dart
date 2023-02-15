import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/Function/Note_Data_Calling.dart';
import 'package:note_app/Provider/App_Color/App_theme.dart';
import 'package:note_app/Screens/Screen_Add_Note.dart';
import 'package:note_app/Screens/Screen_Edit_Note.dart';

import 'package:provider/provider.dart';
import 'package:note_app/note_model/note_model.dart';

const double VD_length = 0;

class Screen_AllNotes extends StatelessWidget {
  Screen_AllNotes({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Data_fuctions.instance.Get_all();
    });
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
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
                      width: 150,
                    ),
                    IconButton(
                      color: themeProvider.Icon_color(),
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.heart),
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
                      icon: Icon(Icons.add_circle))
                ],
              ),
              SizedBox(
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
      ),
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: themeProvider.Inside_Text_color()),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Favorite',
              backgroundColor: themeProvider.Inside_Text_color())
        ],
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
    this.id,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
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
          gradient: LinearGradient(colors: themeProvider.Theme_note()),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.only(left: 5, top: 5),
        child: Column(
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
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: 20,
                    color: Colors.white,
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.heart),
                  ),
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
                    },
                    icon: const Icon(
                      Icons.cancel_rounded,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Divider(
              thickness: 1.5,
              height: 2,
              indent: 1,
              endIndent: 7,
              color: Colors.white,
            ),
            Text(
              content!,
              style: TextStyle(
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
}
