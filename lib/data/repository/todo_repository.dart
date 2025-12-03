import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../models/todo_model.dart';

class TodoRepository{
  Future<List<TodoModel>> getTodos() async {
    final response = await dioClient.dio.get("/todos");

    if (response.statusCode == 200) {
      final model = TodoModel.fromJson(response.data);
      return [model];
    } else {
      throw Exception("Failed to fetch todos");
    }
  }
}
