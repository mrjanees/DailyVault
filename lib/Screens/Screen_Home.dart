import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:note_app/Function/fav_data_function.dart';
import 'package:note_app/Screens/Screen_All_Notes.dart';
import 'package:note_app/Screens/Screen_Favorite.dart';
import 'package:provider/provider.dart';

import '../Provider/App_Color/App_theme.dart';
import '../Widgets/Custom_Navigation_Bar.dart';
import '../Function/Note_Data_Calling.dart';

List pages = const [
  ScreenAllNotes(),
  ScreenFavorite(),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlert = false;
  var snackbar = SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    backgroundColor: const Color.fromARGB(255, 238, 237, 237),
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

  getconnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && !isAlert) {
        showDialogBox();
        setState(() {
          isAlert = true;
        });
      }
    });
  }

  @override
  void initState() {
    interntCheck();
    getconnectivity();

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final favIconProvider = Provider.of<FavFunction>(context, listen: false);
      Data_fuctions.instance.GetAll();
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

  interntCheck() async {
    final response = await InternetConnectionChecker().hasConnection;
    if (response == false) {
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      return true;
    }
  }

  showDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: context.watch<ThemeProvider>().Inside_Text_color(),
            title: Text(
              'No Internet',
              style: TextStyle(
                  color: context.watch<ThemeProvider>().Headline_Color()),
            ),
            content: Text(
              'Please Check The Internet Connection',
              style: TextStyle(
                  color: context.watch<ThemeProvider>().Headline_Color()),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    setState(() {
                      isAlert = false;
                    });
                    isDeviceConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isDeviceConnected) {
                      showDialogBox();
                      setState(() {
                        isAlert = true;
                      });
                    }
                  },
                  child: Text(
                    'Retry',
                    style: TextStyle(
                        color: context.watch<ThemeProvider>().Headline_Color()),
                  )),
            ],
          );
        });
  }
}
