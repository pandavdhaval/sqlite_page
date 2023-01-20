
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqllite_page/constant.dart';
import 'package:sqllite_page/todo_model.dart';
import 'constant.dart';

class HomePageController extends GetxController{

  var todoList =<TodoModel>[].obs;

  @override

  void onInit() {
    // TODO: implement onInit
    creatDatabase();
    super.onInit();
  }

  Future<void>creatDatabase()async{
    var databasespath = await getDatabasesPath();
    String path = join(databasespath, '${databaseName}');

    await openDatabase(path, version: version,
    onCreate: (Database db , int version)async {
    printInfo(info: "db:"+ db.toString());
      await db.execute("CREATE TABLE $tblName("
          "$columnId TEXT PRIMARY KEY,"
          "$columnTitle TEXT NOT NULL,"
          "$columnDescription TEXT NOT NULL,"
         "$columnDate TEXT NOT NULL"

          ")");
    }
    );
    getTodo();
  }


  void addData({
    required String name,
    required String task,
    required String desc
  }) {
    var todo = TodoModel(
        id: (todoList.length + 1).toString(),
        name:  name,
        task: task,
        desc: desc);
    insertData(todo);
  }

  Future<void> insertData(TodoModel todo)async{
    var databasespath = await getDatabasesPath();
    String path = join(databasespath, '${databaseName}');
    final db = await openDatabase(path);

    print("hello"+todo.toJson().toString());
    await db.insert(tblName,todo.toJson());
    getTodo();
  }

  Future<void>getTodo()async{
    todoList.clear();
    var databasespath = await getDatabasesPath();
    String path = join(databasespath, '${databaseName}');
    final db = await openDatabase(path,version: version);
    final List<Map<String,dynamic>> maps = await db.query((tblName));
    todoList.addAll(maps.map((value)=> TodoModel.fromJson(value)).toList());
    print("dxfds::::${todoList.length}");
  }
}

