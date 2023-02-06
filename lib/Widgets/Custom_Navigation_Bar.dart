import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:provider/provider.dart';

import 'Provider/App_Color/App_theme.dart';

ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);

class NAvigationBar extends StatelessWidget {
  const NAvigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ValueListenableBuilder(
        valueListenable: currentIndexNotifier,
        builder: (BuildContext context, newvalue, Widget? child) {
          return CustomNavigationBar(
            unSelectedColor: themeProvider.navIconcolorUnselected(),
            selectedColor: themeProvider.navIconcolorSelected(),
            onTap: (value) {
              currentIndexNotifier.value = value;
            },
            currentIndex: newvalue,
            backgroundColor: themeProvider.navBarShapeColor(),
            borderRadius: const Radius.circular(10),
            items: [
              CustomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(color: themeProvider.Headline_Color()),
                ),
              ),
              CustomNavigationBarItem(
                  icon: const Icon(Icons.favorite),
                  title: Text(
                    'Favorite',
                    style: TextStyle(color: themeProvider.Headline_Color()),
                  ))
            ],
          );
        },
      ),
    );
  }
}
