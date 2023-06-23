import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/student_model.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final searchText = ''.obs;
  final searchResults = <StudentModel>[].obs;
  final allStudents = <StudentModel>[].obs;
  final noResults = false.obs;

  @override
  void onInit() {
    getStudents();
    super.onInit();
  }

//get students

  Future<List<StudentModel>> getStudents() async {
    List<StudentModel> studentList = [];
    try {
      final students =
          await FirebaseFirestore.instance.collection('Students').get();

      if (students.docs.isEmpty) {
        return [];
      }

      for (var student in students.docs) {
        StudentModel s = StudentModel.fromJson(student.data());
        allStudents.add(s);
      }

      searchResults.value = allStudents;
    } catch (e) {
      log(e.toString());
      log('Error occurred in student getting firebase call');
    }

    return studentList;
  }

  void updateSearchText(String text) {
    searchText.value = text;
    if (text.isEmpty) {
      searchResults.value = allStudents;
      noResults.value = false;
    } else {
      searchResults.value = performSearch(text);
    }
  }

  List<StudentModel> performSearch(String text) {
    final results = allStudents
        .where((student) =>
            student.name.toLowerCase().contains(text.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      searchResults.value = []; // Clear previous results

      noResults.value = true;
    } else {
      noResults.value = false;
    }

    return results;
  }
}
