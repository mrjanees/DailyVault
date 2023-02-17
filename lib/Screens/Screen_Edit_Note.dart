import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/Provider/App_Color/App_theme.dart';
import 'package:note_app/Function/Note_Data_Calling.dart';
import 'package:note_app/Screens/Screen_Home.dart';
import 'package:note_app/Screens/Screen_All_Notes.dart';
import 'package:note_app/note_model/note_model.dart';
import 'package:provider/provider.dart';

final TextEditingController titleTextformfield = TextEditingController();
final TextEditingController contentTextformfield = TextEditingController();
final scaffoldKey = GlobalKey<ScaffoldState>();

class ScreenEditNote extends StatelessWidget {
  final String? id;
  const ScreenEditNote({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final checkedId = Data_fuctions.instance.editNoteById(id!);
    titleTextformfield.text = checkedId!.title ?? 'No Title';
    contentTextformfield.text = checkedId.content ?? 'No Content';
    final themeprovider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_circle_left_sharp),
                        color: themeprovider.Headline_Color(),
                        iconSize: 30,
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Container(
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: themeprovider.Headline_Color()),
                        child: Text(
                          "editnote",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: themeprovider.Inside_Text_color()),
                        ),
                      ),
                      const SizedBox(
                        width: 90,
                      ),
                      IconButton(
                        color: themeprovider.Headline_Color(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () async {
                          clicktoedit();
                          Navigator.of(context)
                              .pop(MaterialPageRoute(builder: (context) {
                            return const ScreenAllNotes();
                          }));
                        },
                        icon: const Icon(Icons.check_circle),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: null,
                    controller: titleTextformfield,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: themeprovider.Headline_Color(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: null,
                    controller: contentTextformfield,
                    style: TextStyle(
                      fontSize: 20,
                      color: themeprovider.Headline_Color(),
                    ),
                    maxLines: null,
                    maxLength: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> clicktoedit() async {
    final title = titleTextformfield.text;
    final content = contentTextformfield.text;
    final editednote = NoteModel.create(id: id, title: title, content: content);
    Data_fuctions.instance.updateAll(editednote);
  }
}
