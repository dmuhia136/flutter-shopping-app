import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/binding.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/firebase_options.dart';
import 'package:sales_app/screens/homescreen.dart';
import 'package:get/get.dart';
import 'package:sales_app/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  bool? animate = true;

  MyApp({super.key, this.animate});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  AuthController authController = Get.put(AuthController());

  // This widget is the root of your application.
  checkLogin() async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        Get.offAll(Welcome());
      } else {
        print(user);
        Get.offAll(HomeScreen());
      }
    });
  }

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: AuthBinding(),
        title: 'Marketing App',
        theme: ThemeData(
          primarySwatch: Colors.lime,
        ),
        home: FutureBuilder(
            future: authController.checkLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Lottie.asset(
                  'assets/images/Aniki Hamster.json',
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                );
              }
              if (snapshot.hasError) {
                print("all oooasd ${snapshot.error}");
              }
              if (snapshot.hasData) {
                return HomeScreen();
              } 
                return Welcome();
              
            }));
  }
}
