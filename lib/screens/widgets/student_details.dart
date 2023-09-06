import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_details_demo_app/db/model/data_model.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key, required this.student});
  final StudentModel student;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 66, 6, 6),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.5)),
          ),
          elevation: 20.5,
          title: const Text('Student Details'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
          leading: const Icon(Icons.arrow_back),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.5),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: const Color.fromARGB(255, 52, 232, 79),
                  backgroundImage: FileImage(File(widget.student.image!)),
                ),
              ),
              _buildInfoCard("Name", widget.student.name, 400),
              _buildInfoCard("Age", widget.student.age, 400),
              _buildInfoCard("Class", widget.student.studentClass, 400),
              _buildInfoCard("Number", widget.student.number, 400),
              _buildInfoCard("Address", widget.student.address, 400),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, double cardWidth) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: cardWidth,
      child: Card(
        elevation: 7.3,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(50.10),
        ),
        color: const Color.fromARGB(255, 6, 43, 24),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
