import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trello_clone_appwrite/home/views/work_space_view.dart';
import 'package:trello_clone_appwrite/home/widgets/board_card_widget.dart';
import 'package:trello_clone_appwrite/routes/app_router.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class HomeView extends HookConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _workSpaceList = ref.watch(workSpaceListProvider);

    return GestureDetector(
      onTap: () {
        // context.router.pushWidget(WorkSpaceView());
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white10,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  AutoRouter.of(context).push(
                    const CreateBoardRoute(),
                  );
                },
                icon: const Icon(Icons.add, size: 35),
              )
            ],
            title: SvgPicture.network(
              "https://images.ctfassets.net/rz1oowkt5gyp/13zrkgNeK4xNziAQIfM3BT/44c6750e80104e3a38a61881c21a0923/trello-logo-blue.svg",
              height: 25,
              color: Colors.white,
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchAnchor.bar(
                  barBackgroundColor: const MaterialStatePropertyAll(
                    Colors.white10,
                  ),
                  isFullScreen: false,
                  barHintText: "Boards",
                  suggestionsBuilder: (context, controller) => [],
                ),
              ),
              20.heightBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: "your workspaces".text.gray300.xl.uppercase.make(),
                  ),
                  _workSpaceList.when(
                    data: (data) => Column(
                        children: List.generate(
                      data.length,
                      (index) => BoardCardWidget(
                          onTap: () {
                            context.router.push(const CardRouteList());
                          },
                          name: data[index].board.isEmpty
                              ? "Add Board"
                              : data[index].board[0].name,
                          boardId: data[index].ownerId,
                          boardName: data[index].name,
                          boardOwner: ""),
                    )),
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
