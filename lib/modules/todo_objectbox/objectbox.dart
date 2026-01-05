import 'package:flutter_crud_demo/modules/todo_objectbox/model.dart';
import 'package:path/path.dart';

import 'objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<Todo> todoBox;

  ObjectBox._create(this.store) {
    todoBox = Box<Todo>(store);
  }

  static Future<ObjectBox> create() async {
    final docsDir = "./database";
    final store = openStore(directory: join(docsDir, "objectbox"));
    // final store = openStore();
    return ObjectBox._create(await store);
  }
}