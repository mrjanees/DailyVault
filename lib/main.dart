import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/Function/Note_Data_Calling.dart';
import 'package:note_app/Function/fav_data_function.dart';
import 'package:note_app/Provider/App_Color/App_theme.dart';
import 'package:note_app/Screens/Home_Screen.dart';
import 'package:note_app/Provider/App_Color/color_constant.dart';
import 'package:note_app/Provider/Fav_Icon/Fav_Icon.dart';
import 'package:note_app/favorite_model/favoriteModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(FavModelAdapter().typeId)) {
    Hive.registerAdapter(FavModelAdapter());
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool IsLightTheme = prefs.getBool(spref_key.isLight) ?? true;
  runApp(StartApp(IsLightTheme: IsLightTheme));
}

class StartApp extends StatelessWidget {
  const StartApp({super.key, required this.IsLightTheme});
  final bool IsLightTheme;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => FavFunction()),
      ChangeNotifierProvider(
          create: (context) => ThemeProvider(IsLightTheme: IsLightTheme))
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData(),
      home: HomeScreen(),
    );
  }
}
