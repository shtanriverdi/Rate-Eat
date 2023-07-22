import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../../../../core/core.dart';

class AuthenticationTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Iconify icon;
  final String validations;

  const AuthenticationTextForm(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.controller,
      required this.validations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Material(
      borderRadius: BorderRadius.all(
        Radius.circular(
          widthCalculator(figmaWidth: 480, screenWidth: width, width: 15),
        ),
      ),
      child: TextFormField(
          controller: controller,
          obscureText: validations == "password",
          decoration: InputDecoration(
              filled: true,
              fillColor: MicroYelpColor.inputField,
              prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(
                    start: width * 0.03, end: width * 0.03),
                child: icon,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: widthCalculator(
                      figmaWidth: 480, screenWidth: width, width: 2),
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              contentPadding: EdgeInsets.all(widthCalculator(
                  figmaWidth: 480, screenWidth: width, width: 20)),
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    widthCalculator(screenWidth: width, width: 18),
                  ),
                ),
                borderSide: BorderSide.none,
              ),
              hintStyle: MicroYelpText.watermark),
          validator: (value) => validationTypeDeterminer(validations, value)),
    );
  }

  validationTypeDeterminer(validate, value) {
    switch (validate) {
      case "firstName":
        return Validations.validateFirstName(value);
      case "lastName":
        return Validations.validateLastName(value);
      case "email":
        return Validations.validateEmail(value);
      case "password":
        return Validations.validatePassword(value);
    }
  }
}
