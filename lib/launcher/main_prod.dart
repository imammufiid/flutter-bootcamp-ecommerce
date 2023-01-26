import 'package:common/utils/setup/app_setup.dart';
import 'package:dependencies/firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/injections/injections.dart';

import '../app/main_app.dart';

void main() async {
  Config.appFlavor = Flavor.production;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Injections().initialize();
  runApp(const MyApp());
}
