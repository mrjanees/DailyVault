import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_app/Theme/App_theme.dart';
import 'package:note_app/Screens/Home_Screen.dart';
import 'package:note_app/Theme/color_constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
