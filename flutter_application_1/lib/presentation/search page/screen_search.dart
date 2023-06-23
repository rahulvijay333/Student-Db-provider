import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/search_controller.dart';
import 'package:get/get.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final instance = Get.put(SearchController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Students'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurple.withOpacity(0.2)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    instance.updateSearchText(value);
                  },
                  decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
            Expanded(
              child: GetX<SearchController>(
                builder: (controller) {
                  if (controller.noResults.value == true) {
                    return const Center(
                      child: Text(
                        'No search results',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(),
                          subtitle: Text(controller.searchResults[index].email),
                          title: Text(controller.searchResults[index].name),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
