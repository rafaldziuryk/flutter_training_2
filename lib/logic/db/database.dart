import 'package:fluttertrainer2/logic/add_post/add_post.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

@DataClassName('AddPostsTable')
class AddPosts extends Table {
  TextColumn get firstName => text().named('first_name')();

  TextColumn get lastName => text().named('last_name')();
}

@UseMoor(tables: [AddPosts])
class MyDatabase extends _$MyDatabase {

  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future createPost(AddPost entry) {
    return into(addPosts).insert(AddPostsTable.fromJson(entry.toJson()));
  }

  Future<List<AddPost>> getPosts() => select(addPosts).get().then((data){
    return data.map((element) => AddPost.fromJson(element.toJson())).toList();
  });
}
