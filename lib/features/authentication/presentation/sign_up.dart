import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/authentication/presentation/authentication_presentation_index.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi_light.dart';
import 'package:iconify_flutter/icons/octicon.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:micro_yelp/features/home/presentation/screens/home_page_navigator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const String route = "/signup";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
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
                top: heightCalculator(screenHeight: height, height: 53),
                bottom: heightCalculator(screenHeight: height, height: 20)),
            child: Column(
              children: <Widget>[
                Image.asset(
                  MicroYelpImage.signUpImage,
                  scale: heightCalculator(screenHeight: height, height: 1.9),
                ),
                SizedBox(
                    height: heightCalculator(screenHeight: height, height: 29)),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Sign up',
                      style: MicroYelpText.mainTitle,
                    )),
                SizedBox(
                    height: heightCalculator(screenHeight: height, height: 37)),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthenticationTextForm(
                        hintText: "First Name",
                        icon: Iconify(Octicon.person_24,
                            color: MicroYelpColor.iconColor,
                            size:
                                widthCalculator(screenWidth: width, width: 20)),
                        controller: firstNameController,
                        validations: "firstName",
                      ),
                      SizedBox(
                          height: heightCalculator(
                              screenHeight: height, height: 10)),
                      AuthenticationTextForm(
                        hintText: "Last Name",
                        icon: Iconify(Octicon.person_24,
                            color: MicroYelpColor.iconColor,
                            size:
                                widthCalculator(screenWidth: width, width: 20)),
                        controller: lastNameController,
                        validations: "lastName",
                      ),
                      SizedBox(
                          height: heightCalculator(
                              screenHeight: height, height: 12)),
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
                      SizedBox(
                          height: heightCalculator(
                              screenHeight: height, height: 12)),
                    ],
                  ),
                ),
                SizedBox(
                    height: heightCalculator(screenHeight: height, height: 40)),
                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    if (state is SignupFailed) {
                      return Text(
                        state.error,
                        style: MicroYelpText.error,
                      );
                    } else if (state is SigningUserUp) {
                      return const CircularProgressIndicator();
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: height * 0.007,
                ),
                BlocListener<SignupBloc, SignupState>(
                  listener: (context, state) {
                    if (state is SignupSuccessful) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomePageNavigator.route, (route) => false);
                    }
                  },
                  child: RoundedButton(
                    buttonText: "Sign up",
                    onClick: () {
                      final formValid = _formKey.currentState!.validate();
                      if (!formValid) return;
                      BlocProvider.of<SignupBloc>(context).add(
                        SignupButtonClicked(
                          email: emailController.text,
                          password: passwordController.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                        ),
                      );
                    },
                    buttonColor: MicroYelpColor.primaryColor,
                    textStyle: MicroYelpText.buttonText,
                  ),
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
                    const Text('Already have account?'),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginPage.route);
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
