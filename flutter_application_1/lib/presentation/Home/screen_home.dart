import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/firebase_provider.dart';
import 'package:flutter_application_1/presentation/add_student/screen_add.dart';
import 'package:flutter_application_1/presentation/search%20page/screen_search.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/instance_manager.dart';
import 'package:provider/provider.dart';

//---------------------------------------------starting page
class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FirebaseProvider>().getStudents();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Students'),
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  //navigator ----------------------------------------add Student
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const ScreenAddStudent();
                    },
                  ));
                },
                icon: const Icon(Icons.person_add))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //-------------------------------------------------------------got to search screen
            Get.to(()=> const ScreenSearch());
          },
          child: const Icon(Icons.search),
        ),

        //-----------------------------------------------------------consumer provider
        body: Consumer<FirebaseProvider>(
          builder: (context, studentlist, child) {
            if (studentlist.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (studentlist.studentlist.isEmpty) {
              return const Center(
                child: Text('No Student Details Available'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: studentlist.studentlist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: const CircleAvatar(),
                        title: Text(studentlist.studentlist[index].name),
                        subtitle: Text(studentlist.studentlist[index].email),
                        trailing: IconButton(
                            onPressed: () async {
                              //delete function

                              bool deleteStatus =
                                  await studentlist.deleteStudent(
                                      id: studentlist.studentlist[index].uid);

                              if (deleteStatus == true) {
                                Get.snackbar('status', 'deleted',
                                    duration: const Duration(seconds: 1),
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            },
                            icon: const Icon(Icons.delete_sweep)),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
