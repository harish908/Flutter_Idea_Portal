import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:idea_portal/constants/routes.dart';
import 'package:idea_portal/controllers/bindings/main_bindings.dart';
import 'package:idea_portal/ui/screens/home/bottom_navigation_bar.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:idea_portal/ui/screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    home: BottomNavigationPage(),
    initialBinding: MainBindings(),
    getPages: AppPages.pages,
    debugShowCheckedModeBanner: false,
  ));
}

// class App extends StatelessWidget {
//   // Create the initialization Future outside of `build`:
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         // if (snapshot.hasError) {
//         //   return Center(
//         //     child: Text('Could not load app'),
//         //   );
//         // }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return GetMaterialApp(
//             home: LoginScreen(),
//             initialBinding: LoginBindings(),
//             getPages: AppPages.pages,
//             debugShowCheckedModeBanner: false,
//           );
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   CircularProgressIndicator(
//                     backgroundColor: Theme.of(context).primaryColor,
//                   )
//                 ],
//               )
//             ]);
//       },
//     );
//   }
// }
