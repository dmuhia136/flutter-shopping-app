import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/binding.dart';
import 'package:sales_app/controllers/authController.dart';
import 'package:sales_app/firebase_options.dart';
import 'package:sales_app/screens/homescreen.dart';
import 'package:get/get.dart';
import 'package:sales_app/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: AuthBinding(),
        title: 'Marketing App',
        theme: ThemeData(
          primarySwatch: Colors.lime,
        ),
        home:  
        FutureBuilder(
            future: authController.checkLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              if (snapshot.hasData) {
                return HomeScreen();
              }

              return Container();
            })
        
        //  StreamBuilder<User?>(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       print(snapshot.data);
        //       return HomeScreen();
        //     } else {
        //       return Welcome();
        //     }
        //   },
        // )
        );
  }
}
