import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:trello_clone_appwrite/auth/controller/auth_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../routes/app_router.dart';

@RoutePage()
class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                          "Create an Account in to Trello"
                              .text
                              .xl
                              .extraBlack
                              .gray500
                              .makeCentered(),
                          20.heightBox,
                          VxTextField(
                            controller: _nameController,
                            borderType: VxTextFieldBorderType.roundLine,
                            clear: false,
                            labelText: "Name",
                            hint: "Enter your name",
                            enabled: true,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Email is Name";
                              }
                              return null;
                            },
                          ),
                          10.heightBox,
                          VxTextField(
                            controller: _emailController,
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
                            controller: _passwordController,
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
                              final route = AutoRouter.of(context);
                              await EasyLoading.show(status: "Loading...");
                              await ref
                                  .read(authControllerProvider.notifier)
                                  .signUp(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text,
                                  );

                              await EasyLoading.dismiss();

                              route.popAndPush(const HomeRoute());
                            },
                            label: "Login".text.make(),
                          ).wFull(context),
                          20.heightBox,
                          OutlinedButton.icon(
                            icon: const Icon(Icons.account_circle),
                            onPressed: () {
                              context.router.push(const SignInRoute());
                            },
                            label: "Already Have Account ".text.make(),
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
                            label: "Continue with Google".text.make(),
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
