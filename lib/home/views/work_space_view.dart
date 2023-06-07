import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trello_clone_appwrite/home/repo/work_space_repo.dart';
import 'package:trello_clone_appwrite/model/work_space_model.dart';

final workSpaceListProvider = FutureProvider<List<WorkSpaceModel>>((ref) async {
  return ref
      .read(WorkSpaceRepo.provider)
      .getWorkSpaces(id: "647ed1b3b124f4558ba8");
});

@RoutePage()

class WorkSpaceView extends ConsumerWidget {
  const WorkSpaceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _workSpaceList = ref.watch(workSpaceListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workspace"),
      ),
      body: _workSpaceList.when(
        data: (data) => data.isEmpty
            ? const Center(child: Text("Ematy"))
            : ListView.builder(
                itemBuilder: (context, index) => CheckboxListTile.adaptive(
                  value: false,
                  onChanged: (value) {},
                  title: Text(data[index].name),
                ),
                itemCount: data.length,
              ),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
