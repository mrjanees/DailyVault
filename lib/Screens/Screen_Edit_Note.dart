import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/Provider/App_Color/App_theme.dart';
import 'package:note_app/Function/Note_Data_Calling.dart';
import 'package:note_app/Screens/Home_Screen.dart';
import 'package:note_app/Screens/Screen_All_Notes.dart';
import 'package:note_app/note_model/note_model.dart';
import 'package:provider/provider.dart';

final TextEditingController Title_Textformfield = TextEditingController();
final TextEditingController Content_Textformfield = TextEditingController();
final _ScaffoldKey = GlobalKey<ScaffoldState>();

class ScreenEditNote extends StatelessWidget {
  final String? id;
  ScreenEditNote({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final Checked_id = Data_fuctions.instance.EditNoteBy_id(id!);
    Title_Textformfield.text = Checked_id!.title ?? 'No Title';
    Content_Textformfield.text = Checked_id.content ?? 'No Content';
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
              constraints: BoxConstraints(),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_circle_left_sharp),
                        color: themeprovider.Headline_Color(),
                        iconSize: 30,
                      ),
                      SizedBox(
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
                      SizedBox(
                        width: 90,
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () async {
                          await clicktoedit();
                          Navigator.of(context)
                              .pop(MaterialPageRoute(builder: (context) {
                            return const ScreenAllNotes();
                          }));
                        },
                        icon: Icon(Icons.check_circle),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: null,
                    controller: Title_Textformfield,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: themeprovider.Headline_Color(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: null,
                    controller: Content_Textformfield,
                    style: TextStyle(
                      fontSize: 20,
                      color: themeprovider.Headline_Color(),
                    ),
                    maxLines: 4,
                    maxLength: 100,
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
    final title = Title_Textformfield.text;
    final content = Content_Textformfield.text;
    final editednote = NoteModel.create(id: id, title: title, content: content);
    Data_fuctions.instance.update_all(editednote);
  }
}
