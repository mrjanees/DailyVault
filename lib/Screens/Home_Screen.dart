import 'package:flutter/material.dart';
import 'package:note_app/Screens/Screen_All_Notes.dart';
import 'package:note_app/Screens/Screen_Favorite.dart';

import '../Custom_Navigation_Bar.dart';
import '../Data/Data_Calling.dart';

const double VD_length = 0;
List pages = const [
  ScreenAllNotes(),
  ScreenFavorite(),
];

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Data_fuctions.instance.Get_all();
    });

    return Scaffold(
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: currentIndexNotifier,
            builder: (context, newvalue, child) {
              return pages[newvalue];
            },
          ),
        ),
        bottomNavigationBar: const NAvigationBar());
  }
}
