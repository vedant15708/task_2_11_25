import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../core/utils/connectivity_service.dart';
import '../data/models/todo_model.dart';
import '../data/repository/todo_repository.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {
  final TodoRepository repository = TodoRepository();

  @observable
  bool isLoading = false;

  @observable
  ObservableList<TodoModel> todos = ObservableList<TodoModel>();

  @action
  Future<String> loadTodos() async{
    final hasInternet = await ConnectivityService.hasInternet();
if(!hasInternet){
  return "No internet connection";
}
try{
  isLoading = true;
  final response = await repository.getTodos();
  todos = ObservableList<TodoModel>.of(response);
  return "Todos loaded sucessfully";
}
catch(e){
  return "Failed to load Todos";
}
finally{
  isLoading = false;
}
}
}