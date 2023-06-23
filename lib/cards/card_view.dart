// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:appflowy_board/appflowy_board.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:trello_clone_appwrite/cards/repo/card_repo.dart';
import 'package:trello_clone_appwrite/dependency/logger.dart';
import 'package:trello_clone_appwrite/model/card_model.dart';

final _cardListProvider = FutureProvider<List<CardModel>?>((ref) async {
  return ref.read(CardRepo.provider).getCards(id: "");
});

@RoutePage()
class CardViewList extends ConsumerWidget {
  const CardViewList({
    @PathParam("boardName") required this.boradName,
  });
  final String boradName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardData = ref.watch(_cardListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(boradName),
      ),
      body: cardData.when(
          data: (data) => CardsView(cardData: data),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              )),
    );
  }
}

// @RoutePage()
class CardsView extends ConsumerStatefulWidget {
  final List<CardModel>? cardData;
  const CardsView({
    required this.cardData,
  });

  @override
  ConsumerState<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends ConsumerState<CardsView> {
  late AppFlowyBoardScrollController boardController;
  late ScrollController scrollController;

  late AppFlowyBoardController controller;

  @override
  void initState() {
    controller = AppFlowyBoardController(
      onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) async {
        debugPrint('Move item from $fromIndex to $toIndex');
      },
      onMoveGroupItem: (groupId, fromIndex, toIndex) {
        debugPrint("Item Movie to different group");
        debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
      },
      onMoveGroupItemToGroup:
          (fromGroupId, fromIndex, toGroupId, toIndex) async {
        final formData = widget.cardData
            ?.where((element) => element.name == fromGroupId)
            .toList()
            .first;
        final toData = widget.cardData
            ?.where((element) => element.name == toGroupId)
            .toList()
            .first;
        formData?.tasks.removeAt(fromIndex);

        toData?.tasks.insert(toIndex, formData!.tasks[fromIndex]);

        await ref.read(CardRepo.provider).updateCard(
            "6482beb23ac596d3d1c0", formData!.copyWith(tasks: formData.tasks));

        await ref.read(CardRepo.provider).updateCard(
            "6482becd2ed541a5bc88", formData!.copyWith(tasks: formData.tasks));

        debugPrint("move itm  to different group");

        debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
      },
    );
    scrollController = ScrollController();

    logger.i("hbdwbhjwn wdbjwdhdwhhj");

    logger.i("7yey782eygvb2ehygy2eb 2u");
    boardController = AppFlowyBoardScrollController();

    for (var i = 0; i < widget.cardData!.length; i++) {
      final group1 = AppFlowyGroupData(
          id: widget.cardData![i].name,
          name: widget.cardData![i].name,
          items: List.generate(
            widget.cardData![i].tasks.length,
            (index) => TextItem(widget.cardData![i].tasks[index].title),
          ));

      controller.addGroup(group1);
    }

    final group1 = AppFlowyGroupData(
        id: widget.cardData![0].name,
        name: widget.cardData![0].name,
        items: List.generate(
          widget.cardData![0].tasks.length,
          (index) => TextItem(widget.cardData![0].tasks[index].title),
        ));

    final group2 = AppFlowyGroupData(
      id: "In Progress",
      name: "In Progress",
      items: <AppFlowyGroupItem>[
        RichTextItem(title: "Card 10", subtitle: 'Aug 1, 2020 4:05 PM'),
        TextItem("Card 11"),
      ],
    );

    final group3 = AppFlowyGroupData(
        id: "Done", name: "Done", items: <AppFlowyGroupItem>[]);

    controller.addGroup(group1);
    // controller.addGroup(group2);
    // controller.addGroup(group3);

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final config = AppFlowyBoardConfig(
      // groupBackgroundColor: Colors.grey.shade100,
      groupBackgroundColor: HexColor.fromHex('#F7F8FC'),
      stretchGroupHeight: false,
    );
    return SafeArea(
      child: Builder(builder: (context) {
        return PrimaryScrollController(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: AppFlowyBoard(
              scrollController: scrollController,
              controller: controller,
              cardBuilder: (context, group, groupItem) {
                return AppFlowyGroupCard(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background),
                  key: ValueKey(groupItem.id),
                  child: _buildCard(groupItem),
                );
              },
              boardScrollController: boardController,
              footerBuilder: (context, columnData) {
                return AppFlowyGroupFooter(
                  icon: const Icon(Icons.add, size: 20),
                  title: const Text('New',
                      style: TextStyle(fontSize: 12, color: Colors.black)),
                  height: 50,
                  margin: config.groupItemPadding,
                  onAddButtonClick: () {
                    boardController.scrollToBottom(columnData.id);
                  },
                );
              },
              headerBuilder: (context, columnData) {
                return AppFlowyGroupHeader(
                  icon: const Icon(Icons.lightbulb_circle, color: Colors.black),
                  title: Container(
                    width: 100,
                    child: TextField(
                      style: TextStyle(fontSize: 12, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                      ),
                      controller: TextEditingController()
                        ..text = columnData.headerData.groupName,
                      onSubmitted: (val) {
                        controller
                            .getGroupController(columnData.headerData.groupId)!
                            .updateGroupName(val);
                      },
                    ),
                  ).card.rounded.make(),
                  addIcon: const Icon(Icons.add, color: Colors.black, size: 20),
                  moreIcon: const Icon(Icons.more_horiz,
                      color: Colors.black, size: 20),
                  height: 50,
                  margin: config.groupItemPadding,
                );
              },
              groupConstraints: const BoxConstraints.tightFor(width: 240),
              config: config),
        );
      }),
    );
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is TextItem) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Text(item.s),
        ),
      );
    }

    if (item is RichTextItem) {
      return RichTextCard(item: item);
    }

    throw UnimplementedError();
  }
}

class TextItem extends AppFlowyGroupItem {
  final String s;

  TextItem(this.s);

  @override
  String get id => s;
}

class RichTextItem extends AppFlowyGroupItem {
  final String title;
  final String subtitle;

  RichTextItem({required this.title, required this.subtitle});

  @override
  String get id => title;
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class RichTextCard extends StatefulWidget {
  final RichTextItem item;
  const RichTextCard({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<RichTextCard> createState() => _RichTextCardState();
}

class _RichTextCardState extends State<RichTextCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.title,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              widget.item.subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
