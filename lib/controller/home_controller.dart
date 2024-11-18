import 'package:get/get.dart';
import 'package:sqflite_with_note_app/classes/db_helper.dart';

class HomeController extends GetxController {
  final DbHelper dbHelper = DbHelper();

  var notes = <Map<String, dynamic>>[].obs; // Observable list to store notes

  @override
  void onInit() {
    super.onInit();
    fetchNotes(); // Fetch notes on initialization
  }

  Future<void> fetchNotes() async {
    final data = await dbHelper.getAllNotes();
    notes.value = data; // Update the observable list with fetched notes
  }

  Future<void> addNote(String title, String note) async {
    await dbHelper.insertNote(title, note);
    await fetchNotes(); // Refresh notes after inserting a new one
  }

  Future<void> deleteNote(int id) async {
    await dbHelper.deleteNote(id);
    await fetchNotes(); // Refresh notes after deleting a note
  }
}
