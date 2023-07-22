import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/authentication/presentation/authentication_presentation_index.dart';
import 'package:micro_yelp/features/authentication/presentation/login_bloc/login_event.dart';
import 'package:iconify_flutter/icons/mdi_light.dart';
import 'package:micro_yelp/features/home/presentation/screens/home_page_navigator.dart';
import 'login_bloc/login_bloc.dart';
import 'login_bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String route = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: DismissKeyboard(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
                left: widthCalculator(screenWidth: width, width: 40),
                right: widthCalculator(screenWidth: width, width: 40),
                top: heightCalculator(screenHeight: height, height: 98),
                bottom: heightCalculator(screenHeight: height, height: 20)),
            child: Column(
              children: <Widget>[
                Image.asset(
                  MicroYelpImage.loginImage,
                  scale: heightCalculator(screenHeight: height, height: 1.3),
                ),
                SizedBox(
                    height: heightCalculator(screenHeight: height, height: 22)),
                Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Log in',
                      style: MicroYelpText.mainTitle,
                    )),
                SizedBox(
                    height: heightCalculator(screenHeight: height, height: 22)),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthenticationTextForm(
                        hintText: "Email",
                        icon: Iconify(MdiLight.email,
                            color: MicroYelpColor.iconColor,
                            size:
                                widthCalculator(screenWidth: width, width: 20)),
                        controller: emailController,
                        validations: "email",
                      ),
                      SizedBox(
                          height: heightCalculator(
                              screenHeight: height, height: 12)),
                      AuthenticationTextForm(
                        hintText: "Password",
                        icon: Iconify(Ri.lock_2_line,
                            color: MicroYelpColor.iconColor,
                            size:
                                widthCalculator(screenWidth: width, width: 20)),
                        controller: passwordController,
                        validations: "password",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: heightCalculator(screenHeight: height, height: 40)),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginFailed) {
                      return Text(
                        state.error,
                        style: MicroYelpText.error,
                      );
                    } else if (state is LoggingIn) {
                      return const CircularProgressIndicator();
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessfull) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomePageNavigator.route, (route) => false);
                      // Navigator.pushReplacementNamed(context, HomePageNavigator.route);
                    }
                  },
                  child: RoundedButton(
                      buttonText: "Login",
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<LoginBloc>(context).add(
                            LoginSubmitted(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                      buttonColor: MicroYelpColor.primaryColor,
                      textStyle: MicroYelpText.buttonText),
                ),
                SizedBox(
                    height: heightCalculator(screenHeight: height, height: 22)),
                GestureDetector(
                  child: Text(
                    'Continue as guest',
                    style: MicroYelpText.price.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: MicroYelpColor.primaryColor),
                  ),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomePageNavigator.route, (route) => false);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('New to ', style: MicroYelpText.watermark),
                    Text("Rate Eat?", style: MicroYelpText.stylishMicroYelp),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpPage.route);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
