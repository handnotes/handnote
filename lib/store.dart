import 'package:client/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  Navigation currentNavigation = Navigation.memo;

  navigateTo(Navigation nav) {
    currentNavigation = nav;
    notifyListeners();
  }
}
