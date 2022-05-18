import 'package:flutter/material.dart';
import 'package:sway_app/bloc/formBloc.dart';

class FromProvider extends InheritedWidget{
  final bloc = FormBloc();

  FromProvider({Key? key, required Widget child}) : super(key: key, child: child);
  
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }


  static FormBloc of(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<FromProvider>() as FromProvider).bloc;
  }
}
