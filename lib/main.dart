import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'Second Page.dart';
import 'First Page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);
  var box = await Hive.openBox('Account');
  runApp(const MyApp());
}

Box box = Hive.box("Account");
var pass = box.get('password');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(pass);
    return GetMaterialApp(
      title: 'Account Manager',
      home: (pass == null) ? FirstPage() : SecondPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
