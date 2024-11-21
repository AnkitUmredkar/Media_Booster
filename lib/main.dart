import 'package:flutter/material.dart';
import 'package:media_booster/provider/theme_provider.dart';
import 'package:media_booster/provider/video_provider.dart';
import 'package:media_booster/view/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => VideoProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
    ], child:  const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDark
          ? themeProvider.darkTheme
          : themeProvider.lightTheme,
      home: const SplashScreen(),
    );
  }
}
