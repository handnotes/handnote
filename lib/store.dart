import 'package:flutter/material.dart';
import 'package:handnote/widgets/navigation_bar.dart';

class AppData extends ChangeNotifier {
  Navigation currentNavigation = Navigation.memo;

  navigateTo(Navigation nav) {
    currentNavigation = nav;
    notifyListeners();
  }
}
