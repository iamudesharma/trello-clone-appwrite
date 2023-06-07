import 'package:appwrite/appwrite.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trello_clone_appwrite/dependency/logger.dart';

import '../../config/appwrite_config.dart';
import '../../dependency/appwrite_dependency.dart';
import '../../model/work_space_model.dart';

final _workSpaceRepoProvider = Provider<IWorkSpaceRepo>((ref) {
  return WorkSpaceRepo(ref.watch(AppWriteDependency.database));
});

abstract class IWorkSpaceRepo {
  Future createWorkSpace(WorkSpaceModel workSpaceModel);
  Future<List<WorkSpaceModel>> getWorkSpaces({required String id});
  Future getWorkSpace(String workSpaceId);
  Future deleteWorkSpace(String workSpaceId);
  Future updateWorkSpace(String workSpaceId, String name, String description);
}

class WorkSpaceRepo extends IWorkSpaceRepo {
  static Provider<IWorkSpaceRepo> get provider => _workSpaceRepoProvider;
  final Databases database;

  WorkSpaceRepo(this.database);

  @override
  Future createWorkSpace(WorkSpaceModel workSpaceModel) async {
    await database.createDocument(
      databaseId: AppWriteConfig.databaseId,
      collectionId: AppWriteConfig.workSpacecollectionId,
      documentId: ID.unique(),
      data: workSpaceModel.toMap(),
    );
  }

  @override
  Future deleteWorkSpace(String workSpaceId) {
    throw UnimplementedError();
  }

  @override
  Future getWorkSpace(String workSpaceId) {
    throw UnimplementedError();
  }

  @override
  Future<List<WorkSpaceModel>> getWorkSpaces({required String id}) async {
    final docs = await database.listDocuments(
        databaseId: AppWriteConfig.databaseId,
        collectionId: AppWriteConfig.workSpacecollectionId,
        queries: [
          Query.search("ownerId", id),
          Query.search("members", id),
        ]);

    if (docs.documents.isEmpty) {
      return [];
    } else {
      logger.i(docs.documents[0].data);
      logger.i(docs.documents[0].toMap());

      final boards =
          docs.documents.map((e) => WorkSpaceModel.fromJson(e.data)).toList();
      return boards;
    }
  }

  @override
  Future updateWorkSpace(String workSpaceId, String name, String description) {
    throw UnimplementedError();
  }
}
