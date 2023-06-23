import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/firebase_functions.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/student_model.dart';

class FirebaseProvider with ChangeNotifier {
  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions();

  

  List<StudentModel> studentlist = [];

  bool loading = false;

  void getStudents() async {
    loading = true;
    studentlist = await _firebaseFunctions.getStudents();

    notifyListeners();
    loading = false;
  }

  Future<bool> addStudent({required StudentModel student}) async {
    final key = uniquekey.v4();
    student.createon = DateTime.now();
    student.uid = key;

    bool addStudentsOperationStatus =
        await _firebaseFunctions.addStudents(studentId: key, student: student);

    getStudents();
    return addStudentsOperationStatus;
  }

  Future<bool> deleteStudent({required String id}) async {
    bool deleteStudentOperationStatus =
        await _firebaseFunctions.deleteStudent(uid: id);

    getStudents();

    return deleteStudentOperationStatus;
  }
}
