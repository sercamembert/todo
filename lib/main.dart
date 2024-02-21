import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/auth.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/pages/edit_task.dart';
import 'package:todo/pages/new_task_page.dart';
import 'package:todo/theme/light_mode.dart';
import 'auth/login_or_register.dart';
import 'pages/home_page.dart';
import 'providers/task_provider.dart'; // Importujemy dostawcę

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
        theme: lightMode,
        routes: {
          '/login_register_page': (context) => const LoginOrRegister(),
          '/home_page': (context) => HomePage(),
          '/create_new_task': (context) => NewTaskPage(),
          '/edit_task': (context) => EditTaskPage(),
        },
      ),
    );
  }
}
