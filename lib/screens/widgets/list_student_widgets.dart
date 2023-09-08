import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_details_demo_app/db/functions/db_functions.dart';
import 'package:student_details_demo_app/screens/widgets/add_student_widgets.dart';
import 'package:student_details_demo_app/screens/widgets/edit_student_list.dart';
import 'package:student_details_demo_app/screens/widgets/student_details.dart';
import '../../db/model/data_model.dart';

class ListStudentWidget extends StatefulWidget {
  const ListStudentWidget({super.key});

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  String search = '';
  List<StudentModel> searchedList = [];

  loadStudentsListData() async {
    final allStudents = await getAllStudentsByList();
    setState(() {
      searchedList = allStudents;
    });
  }

  @override
  void initState() {
    loadStudentsListData();
    searchResultFromList();
    super.initState();
  }

  void searchResultFromList() {
    setState(() {
      searchedList = studentListNotifier.value
          .where((StudentModel) =>
              StudentModel.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllStudentsByList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Data List'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 32, 39, 144),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15.5), top: Radius.circular(15.5))),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddStudentWidget(),
              ));
            },
            icon: const Icon(Icons.add)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(50.10),
          //   child: TextFormField(
          //       decoration: const InputDecoration(
          //           border: OutlineInputBorder(
          //               borderRadius: BorderRadius.vertical(
          //                   bottom: Radius.circular(25.0),
          //                   top: Radius.circular(25.0))),
          //           hintText: 'Search here',
          //           label: Text('Search'),
          //           prefixIcon: Icon(Icons.search)),
          //       onChanged: (value) {
          //         setState(() {
          //           search = value;
          //         });
          //         searchResultFromList();
          //       }),
          // ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder: (BuildContext ctx, List<StudentModel> studentList,
                  Widget? child) {
                return ListView.separated(
                    itemBuilder: (ctx, index) {
                      final data = searchedList[index];
                      return ListTile(
                        onTap: () {
                          navigator(context, data);
                        },
                        title: Text(data.name),
                        shape: const Border(
                            bottom: BorderSide(color: Colors.black)),
                        leading: CircleAvatar(
                            backgroundImage: data.image != null
                                ? FileImage(File(data.image!))
                                : const AssetImage('') //must add image here//
                                    as ImageProvider),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                color: const Color.fromARGB(255, 108, 20, 14),
                                onPressed: () {
                                  deleteStudentsData(index);
                                  
                                },
                                icon: const Icon(Icons.delete)),
                            IconButton(
                                color: const Color.fromARGB(255, 5, 70, 7),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditStudentList(
                                        index: index,
                                        name: data.name,
                                        age: data.age,
                                        studentClass: data.studentClass,
                                        number: data.number,
                                        address: data.address,
                                        imagePath: data.image,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit)),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const Divider();
                    },
                    itemCount: searchedList.length);
              },
            ),
          ),
        ],
      ),
    );
  }

  navigator(BuildContext context, StudentModel student) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentDetails(student: student),
        ));
  }
}
