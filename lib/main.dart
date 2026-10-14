import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_r5_s2/todo/presentation/features/auth/presentation/main%20page/mainScreen.dart';
import 'package:flutter_r5_s2/firebase_options.dart';
import 'todo/Data/local db/SQFLite db/sqflite_task_db.dart';
import 'todo/presentation/state Management/cubit/task_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_r5_s2/e-commerce/cart/cart_provider.dart';
// import 'package:flutter_r5_s2/e-commerce/cart/cart_db.dart';
// import 'todo/state Management/provider/task_provider.dart';
// import 'todo/DataBase/hive db/tasks_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await CartDb().initialDb();
  await SqfliteTaskDb().initialDb();
  // await HiveTasksDb.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.requestPermission();
  final messageToken = await FirebaseMessaging.instance.getToken();
  print("messageToken");
  print(messageToken);
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => TaskProvider()),
        // ChangeNotifierProvider(create: (context) => CartProvider()),
        BlocProvider(create: (context) => TasksCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Mainscreen());
  }
}
