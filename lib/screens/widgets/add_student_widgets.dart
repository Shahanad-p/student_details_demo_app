import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_details_demo_app/db/functions/db_functions.dart';
import 'package:student_details_demo_app/db/model/data_model.dart';
import 'package:student_details_demo_app/screens/widgets/list_student_widgets.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _classController = TextEditingController();
  final _numberController = TextEditingController();
  final _addressController = TextEditingController();
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Students Data'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 8, 84, 5),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15.5), top: Radius.circular(15.5))),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ClipOval(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color.fromARGB(255, 235, 240, 238),
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : const AssetImage("") //must add image here//
                            as ImageProvider,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 41, 19, 102),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        onPressed: () => {_selectImageFromGallery()},
                        child: const Text("Select From Gallery"),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 41, 19, 102),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        onPressed: () => {_selectImageFromCamera()},
                        child: const Text("      Open Camera     "),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    key: const Key('name_field'),
                    controller: _nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(25),
                                top: Radius.circular(25))),
                        label: Text('Name'),
                        hintText: 'Enter your name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _ageController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(25),
                                top: Radius.circular(25))),
                        label: Text('Age'),
                        hintText: 'Enter your age'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
                    ],
                    controller: _classController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(25),
                                top: Radius.circular(25))),
                        label: Text('Class'),
                        hintText: 'Enter your class'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: _numberController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(25),
                                top: Radius.circular(25))),
                        label: Text('Number'),
                        hintText: 'Enter your number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(25),
                                top: Radius.circular(25))),
                        label: Text('Address'),
                        hintText: 'Enter your address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value is Empty ';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 11, 66, 12),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onAddStudentButtonClicked(context);
                    } else {
                      print('data is empty');
                    }
                  },
                  child: const Icon(Icons.add),
                ),
                // label: const Text('Add Student')),
                const SizedBox(
                  height: 15,
                ),
                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //         backgroundColor: const Color.fromARGB(255, 41, 19, 102),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(20.0))),
                //     onPressed: () {
                //       onAddStudentButtonClicked(context);
                //     },
                //     child: const Text(" Open List "))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    final name = _nameController.text.trim();

    final age = _ageController.text.trim();

    final studentClass = _classController.text.trim();

    final number = _numberController.text.trim();

    final address = _addressController.text.trim();

    if (name.isEmpty ||
        age.isEmpty ||
        studentClass.isEmpty ||
        number.isEmpty ||
        address.isEmpty) {
      return;
    }
    // print('$_name $_age $_studentClass $_number $_address');

    // ignore: no_leading_underscores_for_local_identifiers
    final student = StudentModel(
        name: name,
        age: age,
        studentClass: studentClass,
        number: number,
        address: address,
        image: _selectedImage!.path);

    addStudentsData(student);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ListStudentWidget(),
    ));
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
