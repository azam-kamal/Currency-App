import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'screens/dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        //MultiProvider(
        //      providers: [
        // ChangeNotifierProvider.value(
        //   // create:(ctx) => Products(),
        //   value: Plans(),
        // ),
        // ChangeNotifierProvider.value(
        //   // create:(ctx) => Products(),
        //   value: Prints(),
        // ),

        //     ],
        //    child:
        MaterialApp(
        debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // primaryColor: Colors.black
      ),
      home: Dashboard(),
      routes: {
        Dashboard.routeName: (ctx) => Dashboard(),
        // PlanPage.routeName: (ctx) => PlanPage(),
      },
    );
  }
}
