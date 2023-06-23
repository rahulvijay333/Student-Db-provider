import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/firebase_provider.dart';
import 'package:flutter_application_1/model/student_model.dart';
import 'package:flutter_application_1/presentation/Home/screen_home.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:provider/provider.dart';

class ScreenAddStudent extends StatefulWidget {
  const ScreenAddStudent({super.key});

  @override
  State<ScreenAddStudent> createState() => _ScreenAddStudentState();
}

class _ScreenAddStudentState extends State<ScreenAddStudent> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  String nameError = '';

  String emailError = '';

  String ageError = '';

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Container(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            nameError = 'Name required';
                          });
                        } else {
                          setState(() {
                            nameError = '';
                          });
                        }

                        //return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: 15,
                    child: Text(
                      nameError,
                      style: const TextStyle(color: Colors.red),
                    )),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            emailError = 'Email required';
                          });
                        } else {
                          setState(() {
                            emailError = '';
                          });
                        }
                        //return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: 15,
                    child: Text(
                      emailError,
                      style: const TextStyle(color: Colors.red),
                    )),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _ageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            
                            ageError = 'age required';
                          });
                        } else {
                          setState(() {
                            ageError = '';
                          });
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Age',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: 15,
                    child: Text(
                      ageError,
                      style: const TextStyle(color: Colors.red),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        if (_nameController.text == '' ||
                            _ageController.text == '' ||
                            _emailController.text == '') {
                         
                        } else {
                          StudentModel student = StudentModel(
                              name: _nameController.text,
                              age: _ageController.text,
                              email: _emailController.text,
                              uid: '');

                          //call firebase provider

                          bool status = await context
                              .read<FirebaseProvider>()
                              .addStudent(student: student);

                          //--------------------------check status of add operations
                          if (status = true) {
                            //-------------------------go to home page
                            Get.back();
                            Future.delayed(const Duration(seconds: 2))
                                .then((value) {
                              Get.snackbar('Status', 'Student added',
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.BOTTOM);
                            });
                          }
                        }
                      }
                    },
                    child: const Text('Add Student'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
