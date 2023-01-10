import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class IntroScreenProvider extends ChangeNotifier {

  var isSkipped;
  get changelanguage => isSkipped;

  void changeLanguages(bool value) {
    isSkipped = value;
    if(value){
      //print(value);
    }

    notifyListeners();
  }


}
