import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trello_clone_appwrite/config/appwrite_config.dart';
import 'package:trello_clone_appwrite/dependency/appwrite_dependency.dart';
import 'package:trello_clone_appwrite/dependency/logger.dart';
import 'package:trello_clone_appwrite/dependency/repository_exception.dart';
import 'package:trello_clone_appwrite/model/board_model.dart';

final _boardRepoProvider = Provider<IBoardRepo>((ref) {
  return BoardRepo(ref.watch(AppWriteDependency.database));
});

abstract class IBoardRepo {
  Future createBoard(BoardModel boardModel);
  Future<List<BoardModel>> getBoards({required String id});
  Future getBoard(String boardId);
  Future deleteBoard(String boardId);
  Future updateBoard(String boardId, String name, String description);
}

class BoardRepo extends IBoardRepo with RepositoryExceptionMixin {
  static Provider<IBoardRepo> get provider => _boardRepoProvider;
  final Databases database;

  BoardRepo(this.database);

  @override
  Future createBoard(BoardModel boardModel) async {
    final doc = await exceptionHandler<Document>(database.createDocument(
      databaseId: AppWriteConfig.databaseId,
      collectionId: AppWriteConfig.boardcollectionId,
      documentId: ID.unique(),
      data: boardModel.toJson(),
    ));

    logger.i(doc.data);
  }

  @override
  Future deleteBoard(String boardId) {
    throw UnimplementedError();
  }

  @override
  Future getBoard(String boardId) {
    throw UnimplementedError();
  }

  @override
  Future<List<BoardModel>> getBoards({required String id}) async {
    final docs = await database.listDocuments(
        databaseId: AppWriteConfig.databaseId,
        collectionId: AppWriteConfig.boardcollectionId,
        queries: [
          Query.search("members", id),
          Query.search("ownerId", id),
        ]);

    print(docs.documents[0].data);
    print(docs.documents.length);
    print(docs.total);
    final boards =
        docs.documents.map((e) => BoardModel.fromJson(e.data)).toList();
    return boards;
  }

  @override
  Future updateBoard(String boardId, String name, String description) {
    throw UnimplementedError();
  }
}
