import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 20),
          child: const CircularProgressIndicator(
          )
        );
  }
}
