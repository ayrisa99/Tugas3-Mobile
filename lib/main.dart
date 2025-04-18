import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas3_tpm/utils/session_manager.dart';
import 'controllers/navigation_controller.dart';
import 'pages/login.dart';
import 'pages/home.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final isLoggedIn = await SessionManager.isLoggedIn();

//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: isLoggedIn ? HomePage() : LoginPage(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => NavigationController(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: '/',
//         routes: {
//           '/': (context) => LoginPage(),
//           '/home': (context) => HomePage(),
//         },
//       ),
//     );
//   }
// }
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: SessionManager.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading sementara
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          // Jika login -> HomePage, kalau belum -> LoginPage
          return snapshot.data == true ? HomePage() : LoginPage();
        },
      ),
    );
  }
}
