import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:trello_clone_appwrite/config/appwrite_config.dart';
import 'package:velocity_x/velocity_x.dart';

Client client = Client();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(
      desktop: 800,
      tablet: 550,
      watch: 200,
    ),
  );
  client
      .setEndpoint(AppWriteConfig.endpoint)
      .setProject(AppWriteConfig.project)
      .setSelfSigned(status: AppWriteConfig.selfSigned);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(builder: (context) {
      return MaterialApp(
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
          home: const LoginView());
    });
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF7F9FB),
        body: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            return Column(
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
                          icon: Icon(Icons.login),
                          onPressed: () {},
                          label: "Login".text.make(),
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
            );
          },
        ),
      ),
    );
  }
}
