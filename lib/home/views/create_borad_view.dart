// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trello_clone_appwrite/home/repo/board_repo.dart';
import 'package:trello_clone_appwrite/home/views/select_backgrand_view.dart';
import 'package:trello_clone_appwrite/home/views/work_space_view.dart';
import 'package:trello_clone_appwrite/model/board_model.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class CreateBoardView extends ConsumerStatefulWidget {
  const CreateBoardView({super.key});

  @override
  ConsumerState<CreateBoardView> createState() => _CreateBoardViewState();
}

class _CreateBoardViewState extends ConsumerState<CreateBoardView> {
  late TextEditingController _boardNameController;
  @override
  void initState() {
    _boardNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _colorAndImageProvider = ref.watch(colorAndImageProvider);
    final _workSpaceList = ref.watch(workSpaceListProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Board"),
        actions: [
          TextButton(
            onPressed: () async {
              await ref.read(BoardRepo.provider).createBoard(BoardModel(
                    // members: [],
                    id: ID.unique(),
                    // ownerId: _workSpaceList.value![0].ownerId,
                    name: _boardNameController.text,
                    background: _colorAndImageProvider.color!.length == 1
                        ? "${_colorAndImageProvider.image}"
                        : "${_colorAndImageProvider.color![0].toHex()}|${_colorAndImageProvider.color![1].toHex()}",

                    cards: [],
                  ));
            },
            child: Text(
              "Create",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: _boardNameController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "New Board",
            ),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            child: Row(
              children: [
                const Text("Workspace"),
                const Spacer(),
                _workSpaceList.when(
                  data: (data) => Text(data[0].name ?? ""),
                  error: (error, stackTrace) => Container(),
                  loading: () => const CircularProgressIndicator.adaptive(),
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            child: Row(
              children: [
                const Text("Background"),
                const Spacer(),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CustomColorBox(
                    onTap: () {
                      context.router.pushWidget(const SelectBackgroundView());
                    },
                    colors: _colorAndImageProvider.color,
                    image: _colorAndImageProvider.image,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomColorBox extends ConsumerWidget {
  const CustomColorBox({
    Key? key,
    this.colors,
    this.onTap,
    this.isSelected = false,
    this.image,
  }) : super(key: key);

  final List<Color>? colors;
  final void Function()? onTap;
  final bool? isSelected;
  final String? image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: colors?.length == 1 ? colors![0] : Colors.white,
                borderRadius: BorderRadius.circular(5),
                image: image != null
                    ? DecorationImage(
                        image: NetworkImage(image!), fit: BoxFit.cover)
                    : null,
                gradient: colors!.length > 1
                    ? LinearGradient(
                        colors: colors!,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
              ),
            ),
          ),
          Positioned.fill(
            child: isSelected!
                ? Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
