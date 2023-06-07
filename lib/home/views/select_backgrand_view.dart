import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trello_clone_appwrite/home/views/create_borad_view.dart';
import 'package:velocity_x/velocity_x.dart';

final colorAndImageProvider = StateProvider<ColorAndImageModel>((ref) {
  return ColorAndImageModel(color: [Colors.blue]);
});

class ColorAndImageModel {
  final String? image;
  final List<Color>? color;
  final String? name;

  ColorAndImageModel({this.image, this.color, this.name});
}

@RoutePage()
class SelectBackgroundView extends ConsumerStatefulWidget {
  const SelectBackgroundView({super.key});

  @override
  ConsumerState<SelectBackgroundView> createState() =>
      _SelectBackgroundViewState();
}

class _SelectBackgroundViewState extends ConsumerState<SelectBackgroundView> {
  final colorsList = [
    ColorAndImageModel(color: [
      const Color(0xffffafbd),
      const Color(0xffffc3a0),
    ], name: "Roseanna"),
    ColorAndImageModel(
        name: "Sexy Blue",
        color: [const Color(0xff2193b0), const Color(0xff6dd5ed)]),
    ColorAndImageModel(
        image: "Purple Love",
        color: [const Color(0xffcc2b5e), const Color(0xff753a88)]),
    ColorAndImageModel(
        name: "Piglet",
        color: [const Color(0xffee9ca7), const Color(0xffffdde1)]),
    ColorAndImageModel(
        name: "Mauve",
        color: [const Color(0xff42275a), const Color(0xff734b6d)]),
    ColorAndImageModel(
        name: "Socialive",
        color: [const Color(0xff06beb6), const Color(0xff48b1bf)]),
  ];

  final image = [
    ColorAndImageModel(
        color: [Colors.white],
        image:
            "https://plus.unsplash.com/premium_photo-1680507425822-f9066024f13b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YmFjayUyMGdyb3VuZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60"),
    ColorAndImageModel(
        color: [Colors.white],
        image:
            "https://images.unsplash.com/photo-1605246811037-7a815fa646e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8YmFjayUyMGdyb3VuZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60"),
    ColorAndImageModel(
        color: [Colors.white],
        image:
            "https://images.unsplash.com/photo-1524055988636-436cfa46e59e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGJhY2slMjBncm91bmR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60"),
    ColorAndImageModel(
        color: [Colors.white],
        image:
            "https://images.unsplash.com/photo-1612141705555-ff32157f0ac9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGJhY2slMjBncm91bmR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select Background"),
        ),
        body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
          ),
          children: [
            GestureDetector(
              onTap: () {
                context.router.pushWidget(
                  ColorGridPicker(colorsList: colorsList),
                  fullscreenDialog: true,
                );
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      child: Image.network(
                        "https://images.unsplash.com/photo-1541701494587-cb58502866ab?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80",
                        fit: BoxFit.cover,
                      ).card.roundedLg.make(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: "Colors".text.white.xl2.center.make().pSymmetric(
                            h: 30,
                            v: 10,
                          ),
                    )
                        .card
                        .color(Colors.black.withOpacity(0.1))
                        .roundedLg
                        .make(),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                context.router.pushWidget(
                  ImageGridPicker(image: image),
                  fullscreenDialog: true,
                );
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                        child: Image.network(
                      "https://images.unsplash.com/photo-1502691876148-a84978e59af8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80",
                      fit: BoxFit.cover,
                    )).card.roundedLg.make(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: "Images".text.white.xl2.center.make().pSymmetric(
                            h: 30,
                            v: 10,
                          ),
                    )
                        .card
                        .color(Colors.black.withOpacity(0.1))
                        .roundedLg
                        .make(),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class ImageGridPicker extends ConsumerStatefulWidget {
  const ImageGridPicker({
    super.key,
    required this.image,
  });

  final List<ColorAndImageModel> image;

  @override
  ConsumerState<ImageGridPicker> createState() => _ImageGridPickerState();
}

class _ImageGridPickerState extends ConsumerState<ImageGridPicker> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Images"),
          actions: [
            if (selectedIndex != null)
              TextButton(
                child: const Text("Done"),
                onPressed: () {
                  ref.read(colorAndImageProvider.notifier).update(
                        (state) => widget.image[selectedIndex!],
                      );

                  context.pop();
                },
              )
          ],
        ),
        body: GridView.builder(
          itemCount: widget.image.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
          itemBuilder: (context, index) => CustomColorBox(
            image: widget.image[index].image,
            colors: const [Colors.white],
            isSelected: index == selectedIndex ? true : false,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ));
  }
}

class ColorGridPicker extends ConsumerStatefulWidget {
  const ColorGridPicker({
    super.key,
    required this.colorsList,
  });

  final List<ColorAndImageModel> colorsList;

  @override
  ConsumerState<ColorGridPicker> createState() => _ColorGridPickerState();
}

class _ColorGridPickerState extends ConsumerState<ColorGridPicker> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Colors"),
          actions: [
            if (selectedIndex != null)
              TextButton(
                child: const Text("Done"),
                onPressed: () {
                  ref.read(colorAndImageProvider.notifier).update(
                        (state) => widget.colorsList[selectedIndex!],
                      );

                  context.pop();
                },
              )
          ],
        ),
        body: GridView.builder(
          itemCount: widget.colorsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
          itemBuilder: (context, index) => CustomColorBox(
            colors: widget.colorsList[index].color,
            isSelected: index == selectedIndex ? true : false,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ));
  }
}
