import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:note_app/Function/Note_Data_Calling.dart';
import 'package:note_app/Provider/App_Color/App_theme.dart';
import 'package:note_app/Widgets/Note.dart';
import 'package:provider/provider.dart';

import '../note_model/note_model.dart';

ValueNotifier<List<NoteModel>> searchNotifier =
    ValueNotifier(List.from(NoteNotifier.value));

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Search',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.Headline_Color()),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'Notes',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.Headline_Color()),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                onChanged: (value) {
                  filtersearch(value);
                },
                style: TextStyle(color: themeProvider.Headline_Color()),
                decoration: InputDecoration(
                    hintText: 'search',
                    hintStyle: TextStyle(color: themeProvider.Headline_Color()),
                    fillColor: themeProvider.navBarShapeColor(),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none)),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: searchNotifier,
                builder: (context, List<NoteModel> newValue, child) {
                  return GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
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
    );
  }
}

void filtersearch(String title) {
  if (title.isEmpty) {
    searchNotifier.value = NoteNotifier.value.toList();
  } else {
    searchNotifier.value = NoteNotifier.value
        .where((element) =>
            element.title!.toLowerCase().contains(title.toLowerCase()))
        .toList();
  }
}
