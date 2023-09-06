import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudentsData(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  await studentDB.add(value);
  getAllStudentsByList(); // call this to update the list//
  // studentListNotifier.value.add(value);
  // studentListNotifier.notifyListeners();
}

Future<void> editStudentsList(index, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_');
  // studentListNotifier.value.clear();
  // studentListNotifier.value.addAll(studentDB.values);
  // studentListNotifier.notifyListeners();
  studentDB.putAt(index, value);
  getAllStudentsByList(); // call this to update the list//
}

Future<void> deleteStudentsData(int index) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(index);
  getAllStudentsByList(); // call this to update the list//
  // studentListNotifier.notifyListeners();
}

getAllStudentsByList() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final students = studentDB.values.toList();
  studentListNotifier.value = students;
  studentListNotifier.notifyListeners();
  // studentListNotifier.notifyListeners();
}
