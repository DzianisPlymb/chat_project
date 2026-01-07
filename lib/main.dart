import 'package:chat_project/screens/login_screen.dart';
import 'package:chat_project/screens/chat_screen.dart';
import 'package:chat_project/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC_t-R8ydY0vTVOkzU2cKN-RXR9mOLf8Rw",
      appId: "1:1078384754102:android:3e850e999763ba5d895517",
      messagingSenderId: "1078384754102",
      projectId: "chatproject-13f2b",
      storageBucket: "chatproject-13f2b.firebasestorage.app"
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Указываем начальный маршрут, чтобы избежать путаницы при выходе из системы
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/chat': (context) => const ChatScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
