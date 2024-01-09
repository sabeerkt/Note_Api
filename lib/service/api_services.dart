import 'package:dio/dio.dart';
import 'package:note/model/model.dart';


class ApiService {
  Dio dio = Dio();     
  var endpointUrl = 'https://657d7dda853beeefdb9ace89.mockapi.io/notes';

  Future<List<NotesModel>> getNotes() async {
    try {
      Response response = await dio.get(endpointUrl);
      if (response.statusCode == 200) {
        var jsonList = response.data as List;
        List<NotesModel> notes = jsonList.map((json) {
          return NotesModel.fromJson(json);
        }).toList();
        return notes;
      } else {
        throw Exception('Failed to load notes');
      }
    } catch (error) {
      throw Exception('Failed to load notes: $error');
    }
  }

  createNotes(NotesModel value) async {
    try {
      await dio.post(endpointUrl, data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  deleteNotes({required id}) async {
    var deleteUrl = 'https://657d7dda853beeefdb9ace89.mockapi.io/notes/$id';
    try {
      await dio.delete(deleteUrl);
    } catch (e) {
      throw Exception(e);
    }
  }

  editNotes({
    required NotesModel value,
    required id,
  }) async {
    try {
      await dio.put('https://657d7dda853beeefdb9ace89.mockapi.io/notes/$id',
          data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
