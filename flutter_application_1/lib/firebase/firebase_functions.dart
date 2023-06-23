import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/student_model.dart';

class FirebaseFunctions {
  final firebaseInstance = FirebaseFirestore.instance;

//add student

  Future<bool> addStudents(
      {required String studentId, required StudentModel student}) async {
    try {
      firebaseInstance
          .collection('Students')
          .doc(studentId)
          .set(student.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

//get students

  Future<List<StudentModel>> getStudents() async {
    List<StudentModel> studentList = [];
    try {
      final students = await firebaseInstance
          .collection('Students')
          .orderBy('createon', descending: true)
          .get();

      if (students.docs.isEmpty) {
        return [];
      }

      for (var student in students.docs) {
        StudentModel s = StudentModel.fromJson(student.data());
        studentList.add(s);
      }
    } catch (e) {
      log(e.toString());
      log('Error occurred in student getting firebase call');
    }

    return studentList;
  }

//edit student

//delete student

  Future<bool> deleteStudent({required String uid}) async {
    bool deleteStatus = false;

    try {
      await firebaseInstance.collection('Students').doc(uid).delete();
      return deleteStatus = true;
    } catch (e) {
      return deleteStatus = false;
    }
  }


  void get(){
    
  }
}
