import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:trello_clone_appwrite/config/appwrite_config.dart';

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
          theme: ThemeData(useMaterial3: true), home: const LoginView());
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
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 300,
                      maxHeight: 500,
                      maxWidth: 450,
                      minWidth: 300,
                    ),
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
