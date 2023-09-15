import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_details_demo_app/screens/widgets/list_student_widgets.dart';
import '../../db/functions/db_functions.dart';
import '../../db/model/data_model.dart';
// ignore: unused_import
import 'path_to_edit_student_list.dart';

// ignore: must_be_immutable
class EditStudentList extends StatefulWidget {
  var name;
  var age;
  var studentClass;
  var number;
  var address;
  int index;

  dynamic imagePath;

  EditStudentList({
    required this.index,
    required this.name,
    required this.age,
    required this.studentClass,
    required this.number,
    required this.address,
    required imagePath,
  });

  @override
  State<EditStudentList> createState() => _EditStudentListState();
}

class _EditStudentListState extends State<EditStudentList> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _ageController = TextEditingController(text: widget.age);
    _classController = TextEditingController(text: widget.studentClass);
    _numberController = TextEditingController(text: widget.number);
    _addressController = TextEditingController(text: widget.address);
    _selectedImage = widget.imagePath != '' ? File(widget.imagePath) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 18, 201),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15.5), top: Radius.circular(15.5))),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : const AssetImage("") // add image here
                          as ImageProvider,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () => {_selectImageFromGallery()},
                    child: const Text("Select From Gallery")),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () => {_selectImageFromCamera()},
                    child: const Text("      Open Camera     ")),
                const SizedBox(
                  height: 10,
                ),
                // ignore: avoid_unnecessary_containers
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: 'Name'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _ageController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Age',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          maxLength: 10,
                          controller: _classController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: 'Class'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _numberController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Number',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Address'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            updateAllDataDetails();
                          },
                          child: const Text('Update')),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateAllDataDetails() async {
    final name1 = _nameController.text.trim();
    final age1 = _ageController.text.trim();
    final class1 = _classController.text.trim();
    final number1 = _numberController.text.trim();
    final address1 = _addressController.text.trim();
    final image1 = _selectedImage!.path;
    if (name1.isEmpty ||
        age1.isEmpty ||
        class1.isEmpty ||
        number1.isEmpty ||
        address1.isEmpty ||
        image1.isEmpty) {
      return;
    } else {
      final update = StudentModel(
          name: name1,
          age: age1,
          studentClass: class1,
          number: number1,
          address: address1,
          image: image1);
      editStudentsList(widget.index, update);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ListStudentWidget()));
    }
  }

  Future _selectImageFromGallery() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedimage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(returnedimage.path);
    });
  }

  _selectImageFromCamera() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedimage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(returnedimage.path);
    });
  }
}
