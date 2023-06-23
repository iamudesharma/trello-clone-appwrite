import 'package:appwrite/appwrite.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trello_clone_appwrite/config/appwrite_config.dart';

import '../../dependency/appwrite_dependency.dart';
import '../../dependency/logger.dart';
import '../../model/card_model.dart';

final _cardProvider = Provider<ICardRepo>((ref) {
  return CardRepo(ref.watch(AppWriteDependency.database));
});

abstract class ICardRepo {
  Future createCard(CardModel cardModel);
  Future<List<CardModel>>? getCards({required String id});
  Future getCard(String cardId);
  Future deleteCard(String cardId);
  Future<void> updateCard(String cardId, CardModel cardModel);
}

class CardRepo extends ICardRepo {
  static Provider<ICardRepo> get provider => _cardProvider;
  final Databases database;

  CardRepo(this.database);
  @override
  Future createCard(CardModel cardModel) {
    // TODO: implement createCard
    throw UnimplementedError();
  }

  @override
  Future deleteCard(String cardId) {
    // TODO: implement deleteCard
    throw UnimplementedError();
  }

  @override
  Future getCard(String cardId) {
    // TODO: implement getCard
    throw UnimplementedError();
  }

  @override
  Future<List<CardModel>>? getCards({required String id}) async {
    final data = await database.listDocuments(
      collectionId: AppWriteConfig.cardcollectionId,
      databaseId: AppWriteConfig.databaseId,
      queries: [],
    );

    logger.i(data.documents[0].data);

    if (data.documents.isEmpty) {
      print("empty");
      return [];
    } else {
      print(data.documents[0].data);
      final docs = data.documents
          .map((e) => CardModel.fromJson(e.data, isFromCard: true))
          .toList();
      logger.d(docs.length);
      logger.d(docs[0].toJson());

      return docs;
    }
  }

  @override
  Future<void> updateCard(String cardId, CardModel model) async {
    database.updateDocument(
      collectionId: AppWriteConfig.cardcollectionId,
      databaseId: AppWriteConfig.databaseId,
      documentId: cardId,
      data: model.toJson(),
    );
  }
}
