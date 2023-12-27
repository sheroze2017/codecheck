import 'package:automata_project/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "AutomataProject",
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBD6DfuTlqwshYOJ5-hCpUvrOBQa55HlMw',
          appId: '1:283370780667:android:91dc2a480f491b9a683d5e',
          messagingSenderId:
              '283370780667-2eogk642abn5jerroebg1130cti6senu.apps.googleusercontent.com',
          projectId: 'automataproject-1c1e7'));

  // Stripe.publishableKey =
  //     "pk_test_51MgUiIA9QdEaEEUcexX0Zu8N6xLEuuRb291R19hB5vQZCGwZI7SJqSTvxHNBplsbLGeKNQWk9LvOCs6Qm7Of3cLS007MSLsRgm";

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'chatapp',
        home: LoginScreen(),
      );
    });
  }
}
