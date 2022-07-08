import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CircularProgressProvider with ChangeNotifier{
  bool _value=false;
  bool get getValue=>_value;
  setValue(bool value){
    value=_value;
    notifyListeners();
  }
}