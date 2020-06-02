import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:risknt/models/user.dart';
import 'package:risknt/notifier/problemNotifier.dart';
import 'package:risknt/screens/wrapper.dart';
import 'package:risknt/services/auth.dart';

import 'models/user.dart';
import 'notifier/problemNotifier.dart';
import 'screens/wrapper.dart';
import 'services/auth.dart';


void main() async {
  runApp(MultiProvider(
  providers:[
    ChangeNotifierProvider(
      create: (context) => ProblemNotifier(),
  ),
  ],
  child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Usuarios>.value(
      value:AuthService().user, 
        child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

