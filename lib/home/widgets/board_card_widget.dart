// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';
import 'package:velocity_x/velocity_x.dart';

class BoardCardWidget extends StatelessWidget {
  const BoardCardWidget({
    Key? key,
    required this.boardOwner,
    required this.boardName,
    required this.boardId,
  }) : super(key: key);

  final String boardOwner;
  final String boardName;
  final String boardId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_2_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  10.widthBox,
                  "Name".text.xl.make(),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  "Boards".text.xl.make(),
                  10.widthBox,
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
            decoration: const BoxDecoration(
                color: Colors.white10,
                border: Border.symmetric(
                    horizontal: BorderSide(
                  color: Colors.grey,
                ))),
            height: 50,
            width: MediaQuery.of(context).size.width),
      ],
    );
  }
}
