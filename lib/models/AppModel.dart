import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  ThemeMode _themeMode;
  ThemeMode get themeMode => this._themeMode;

  AppModel({ThemeMode themeMode: ThemeMode.light}) {
    this._themeMode = themeMode;
    notifyListeners();
  }

  setThemeMode(ThemeMode themeMode) {
    this._themeMode = themeMode;
    notifyListeners();
  }

  toggleThemeMode() {
    this._themeMode = themeMode == ThemeMode.light ?  ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  static AppModel of(BuildContext context) => ScopedModel.of<AppModel>(context);
}
