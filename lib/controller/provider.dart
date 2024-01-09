import 'package:flutter/material.dart';
import 'package:note/model/model.dart';
import 'package:note/service/api_services.dart';


class HomeProvider extends ChangeNotifier {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  List<NotesModel> noteList = [];
  void loadNotes() async {
    try {
      List<NotesModel> notes = await ApiService().getNotes();
      noteList = notes;
    } catch (error) {
      print('Error loading notes: $error');
    }
    notifyListeners();
  }

  addNotes(BuildContext context) async {
    final name = titlecontroller.text;
    final description = descriptioncontroller.text;
    await ApiService()
        .createNotes(NotesModel(description: description, name: name));
    loadNotes();
    Navigator.pop(context);

    notifyListeners();
  }

  deleteNote({required id}) async {
    await ApiService().deleteNotes(id: id);
    loadNotes();
    notifyListeners();
  }

  updateNotes({required id}) {
    var titleEdit = titlecontroller.text;
    var descriptionEdit = descriptioncontroller.text;
    loadNotes();
    ApiService().editNotes(
        id: id,
        value: NotesModel(name: titleEdit, description: descriptionEdit));
    notifyListeners();
  }
}
