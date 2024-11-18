import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_with_note_app/controller/home_controller.dart';
import 'package:sqflite_with_note_app/screens/home.dart';

class AllNotes extends StatelessWidget {
  const AllNotes({super.key});

  @override
  Widget build(BuildContext context) {
    
    var size = Get.size;
    RxBool shouldShowDeleteUi = false.obs;
    RxInt selectedIndex = 0.obs;

    final HomeController controller = Get.find<HomeController>(); // Access the controller

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              // onTap: () => Get.toNamed('/all-notes'),
              onTap: () => Get.to(() => const Home()),
              child: const Icon(Icons.edit_square, color: Colors.white,)),
          ),
        ],
        title: const Text(
          'Loose Leaf',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.notes.isEmpty) {
          return const Center(child: Text("No notes available"));
        }
        
        return ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            final note = controller.notes[index];
            return Padding(
              padding: index == 0
                  ? const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0)
                  : const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: GestureDetector(
                onLongPress: () {
                  selectedIndex.value = index;
                  shouldShowDeleteUi.value = true;
                },
                child: Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 555),
                  curve: Curves.linearToEaseOut,
                  width: size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                    color: shouldShowDeleteUi.value && selectedIndex.value == index 
                    ? Colors.red 
                    : Colors.transparent
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 555),
                        curve: Curves.linearToEaseOut,
                        opacity: shouldShowDeleteUi.value && selectedIndex.value == index 
                        ? 0 
                        : 1,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                                child: Text(
                                  note['title'] ?? "No Title",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Text(
                              note['note'] ?? "No Content",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                height: 0,
                                fontSize: size.width * 0.041,
                              ),
                            ),
                          )
                        ]),
                      ),
                    
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 555),
                        curve: Curves.linearToEaseOut,
                        opacity: shouldShowDeleteUi.value && selectedIndex.value == index 
                        ? 1 
                        : 0,
                        child: GestureDetector(
                          onTap: shouldShowDeleteUi.value && selectedIndex.value == index 
                          ? () { controller.deleteNote(note['id']); shouldShowDeleteUi.value = false; }
                          : () {}, 
                          child: Text("Delete Leaf",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: size.width * 0.055,
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                ),),              
              ),
            );
          },
        );
      }),
    );
  }
}
