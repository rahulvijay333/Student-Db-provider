import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  String name;
  String age;
  String email;
  String uid;
  DateTime? createon;

  StudentModel(
      {required this.name,
      required this.age,
      required this.email,
      this.createon,
      required this.uid});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
        name: json['name'],
        age: json['age'],
        email: json['email'],
        uid: json['uid'],
        createon: (json["createon"] as Timestamp).toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'email': email,
      'uid': uid,
      'createon': createon
    };
  }
}
