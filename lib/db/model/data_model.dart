import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String studentClass;

  @HiveField(4)
  final String number;

  @HiveField(5)
  final String address;

  @HiveField(6)
  final String? image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.studentClass,
      required this.number,
      required this.address,
      this.id,
      this.image});
}

