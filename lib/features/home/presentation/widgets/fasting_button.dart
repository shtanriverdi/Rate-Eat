import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/features/home/presentation/constants/static_states.dart';

import '../../../../core/utils/constants.dart';
import '../bloc/home_bloc.dart';

class FastingButton extends StatefulWidget {
  const FastingButton({Key? key}) : super(key: key);

  @override
  State<FastingButton> createState() => _FastingButtonState();
}

class _FastingButtonState extends State<FastingButton> {
  bool toggleState = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: width * 0.01),
          child: Text(
            "Fasting",
            textAlign: TextAlign.left,
            style: MicroYelpText.smallCardTitle,
          ),
        ),
        SizedBox(
          width: width * 0.01,
        ),
        CupertinoSwitch(
          activeColor: Colors.orange,
          value: toggleState,
          onChanged: (value) {
            toggleState = !toggleState;
            setState(() {});
            // Update the query, add "fasting=true" to the query
            HomePageStates.isFasting = toggleState.toString();
            // Trigger the event
            context.read<HomeBloc>().add(getTriggerEvent());
          },
        ),
      ],
    );
  }

  GetAllItemsEvent getTriggerEvent() {
    return GetAllItemsEvent(
        selectedCategoryParameter: HomePageStates.selectedCategoryParameter,
        sortBy: HomePageStates.sortBy,
        isFasting: HomePageStates.isFasting,
        latitude: HomePageStates.latitude,
        longitude: HomePageStates.longitude);
  }
}
