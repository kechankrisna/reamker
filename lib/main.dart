import 'package:appnews/models/AppModel.dart';
import 'package:appnews/screens/AuthorScreen.dart';
import 'package:appnews/screens/CategoryScreen.dart';
import 'package:appnews/screens/HomeScreen.dart';
import 'package:appnews/screens/NotFoundScreen.dart';
import 'package:appnews/screens/PostScreen.dart';
import 'package:appnews/screens/SearchScreen.dart';
import 'package:appnews/screens/SettingScreen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'core/app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppModel appModel = AppModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: appModel,
      child: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => MaterialApp(
          title: app_name,
          darkTheme: ThemeData.dark(),
          themeMode: model.themeMode,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: AppBarTheme(color: Colors.black)),
          initialRoute: "/",
          routes: {
            '/': (context) => HomeScreen(),
            '/search': (context) => SearchScreen(),
            '/setting': (context) => SettingScreen(),
          },
          onGenerateRoute: (settings) {
            var args = settings.arguments;
            var name = settings.name;
            switch (name) {
              case "/post":
                return MaterialPageRoute(
                  builder: (_) => PostScreen(
                    post: args,
                  ),
                );
                break;
              case "/category":
                return MaterialPageRoute(
                  builder: (_) => CategoryScreen(
                    category: args,
                  ),
                );
                break;
              case "/author":
                return MaterialPageRoute(
                  builder: (_) => AuthorScreen(
                    author: args,
                  ),
                );
                break;
              default:
                return MaterialPageRoute(builder: (_) => NotFoundScreen());
            }
          },
        ),
      ),
    );
  }
}
