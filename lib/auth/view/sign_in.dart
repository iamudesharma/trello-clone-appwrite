import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../routes/app_router.dart';
import '../controller/auth_controller.dart';

@RoutePage()
class SignInView extends HookConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF7F9FB),
        body: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.screenHeight,
                  ),
                  Center(
                    child: SvgPicture.network(
                        "https://images.ctfassets.net/rz1oowkt5gyp/13zrkgNeK4xNziAQIfM3BT/44c6750e80104e3a38a61881c21a0923/trello-logo-blue.svg"),
                  ),
                  SizedBox(
                    height: 5.screenHeight,
                  ),
                  Card(
                    borderOnForeground: true,
                    elevation: 2,
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      constraints: const BoxConstraints(
                        minHeight: 500,
                        maxHeight: 800,
                        maxWidth: 450,
                        minWidth: 300,
                      ),
                      child: VStack(
                        [
                          "Login in to Trello"
                              .text
                              .xl
                              .extraBlack
                              .gray500
                              .makeCentered(),
                          10.heightBox,
                          VxTextField(
                            borderType: VxTextFieldBorderType.roundLine,
                            clear: false,
                            labelText: "Email",
                            hint: "Enter your email",
                            enabled: true,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Email is required";
                              }
                              return null;
                            },
                          ),
                          10.heightBox,
                          VxTextField(
                            isPassword: true,
                            borderType: VxTextFieldBorderType.roundLine,
                            clear: false,
                            labelText: "Password",
                            hint: "Enter your password",
                            enabled: true,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Email is required";
                              }
                              return null;
                            },
                          ),
                          20.heightBox,
                          ElevatedButton.icon(
                            icon: const Icon(Icons.login),
                            onPressed: () async {
                              await ref
                                  .read(authControllerProvider.notifier)
                                  .signIn(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                            },
                            label: "Login".text.make(),
                          ).wFull(context),
                          20.heightBox,
                          OutlinedButton.icon(
                            icon: const Icon(Icons.account_circle),
                            onPressed: () async {
                              context.router.push(const SignUpRoute());
                            },
                            label: "Create An Account ".text.make(),
                          ).wFull(context),
                          20.heightBox,
                          OutlinedButton.icon(
                            icon: SvgPicture.network(
                              "https://img.icons8.com/?size=512&id=V5cGWnc9R4xj&format=svg",
                              fit: BoxFit.contain,
                              height: 20,
                              width: 20,
                            ),
                            onPressed: () {},
                            label: "Create An Account".text.make(),
                          ).wFull(context),
                          20.heightBox,
                          OutlinedButton.icon(
                            icon: SvgPicture.network(
                              "https://img.icons8.com/?size=512&id=118497&format=svg",
                              fit: BoxFit.contain,
                              height: 20,
                              width: 20,
                            ),
                            onPressed: () {},
                            label: "Continue with Facebook".text.make(),
                          ).wFull(context),
                        ],
                        alignment: MainAxisAlignment.center,
                      ).p12(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
