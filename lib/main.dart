import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_details_demo_app/db/model/data_model_student.dart';
import 'screens/widgets/list_student_widgets.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentModelAdapter());
  // if (Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
  //   Hive.registerAdapter(StudentModelAdapter());
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App Demo',
      theme: ThemeData(),
      home: const ListStudentWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
