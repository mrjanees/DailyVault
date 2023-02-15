import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:note_app/Provider/App_Color/App_theme.dart';
import 'package:note_app/Function/Note_Data_Calling.dart';
import 'package:note_app/Screens/Screen_All_Notes.dart';
import 'package:note_app/note_model/note_model.dart';
import 'package:provider/provider.dart';

import 'Screen_Home.dart';

enum ActionType {
  addnote,
  editnote,
}

final TextEditingController Title_Textformfield = TextEditingController();
final TextEditingController Content_Textformfield = TextEditingController();
var snackbar = SnackBar(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  backgroundColor: const Color.fromARGB(255, 216, 216, 216),
  content: Row(children: const [
    Icon(
      Icons.wifi_off_outlined,
      color: Colors.black87,
    ),
    SizedBox(
      width: 10,
    ),
    Text(
      'No internet Connection',
      style: TextStyle(color: Colors.black87),
    )
  ]),
  duration: const Duration(seconds: 5),
);

class ScreenAddnote extends StatelessWidget {
  ScreenAddnote({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      interntCheck() async {
        final response = await InternetConnectionChecker().hasConnection;
        if (response == false) {
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        } else {
          return true;
        }
      }
    });
    final themeprovider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
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
                              "addnote",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themeprovider.Inside_Text_color()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: Title_Textformfield,
                    style: TextStyle(color: themeprovider.Headline_Color()),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: themeprovider.Headline_Color()),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: themeprovider.Headline_Color()),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Title',
                      hintStyle:
                          TextStyle(color: themeprovider.Headline_Color()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: Content_Textformfield,
                    style: TextStyle(
                      color: themeprovider.Headline_Color(),
                    ),
                    maxLines: 4,
                    maxLength: 2000,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: themeprovider.Headline_Color()),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: themeprovider.Headline_Color()),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Content',
                      hintStyle:
                          TextStyle(color: themeprovider.Headline_Color()),
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    width: 600,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        Click_to_Save();
                        await Data_fuctions.instance.Get_all();
                        Title_Textformfield.clear();
                        Content_Textformfield.clear();
                        Navigator.of(context).pop(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return const ScreenAllNotes();
                            },
                          ),
                        );
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color:
                                              themeprovider.Headline_Color()))),
                          backgroundColor: MaterialStatePropertyAll(
                              ThemeProvider(IsLightTheme: true)
                                  .Headline_Color())),
                      child: const Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void Click_to_Save() async {
    if (Title_Textformfield.text.isEmpty ||
        Content_Textformfield.text.isEmpty) {
      print('Title or Content is null');
    } else {
      final Title = Title_Textformfield.text;
      final Content = Content_Textformfield.text;
      final _data = NoteModel.create(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: Title,
        content: Content,
      );

      await Data_fuctions().create_all(_data);
      Data_fuctions.instance.Get_all();
    }
  }
}
