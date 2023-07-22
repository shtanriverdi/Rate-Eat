import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/features/search/presentation/bloc/search_bloc.dart';
import 'package:micro_yelp/features/search/presentation/bloc/search_event.dart';

import '../../../../core/utils/constants.dart';

class SortByRow extends StatefulWidget {
  final req;
  const SortByRow({Key? key, required this.req}) : super(key: key);

  @override
  State<SortByRow> createState() => _SortByRowState();
}

class _SortByRowState extends State<SortByRow> {
  final ascOrDesc = ["asc", "desc"];
  var dropdownvalue = "Price";
  var initial = "asc";

  var sortMap = <String, String>{
    "Price": "price",
    "Average Rating": "ratingAverage",
  };

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Text(
          "Sort By",
          style: MicroYelpText.smallCardTitle,
        ),
        SizedBox(
          width: width * 0.03,
        ),
        DropdownButton<String>(
          value: dropdownvalue,
          icon: const Icon(Icons.keyboard_arrow_down),
          alignment: AlignmentDirectional.center,
          // Array list of items
          items: sortMap.keys.toList().map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                textAlign: TextAlign.center,
                style: item == dropdownvalue
                    ? MicroYelpText.selectedDropdown
                    : MicroYelpText.activitiesTitle,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              if (dropdownvalue != newValue) {
                dropdownvalue = newValue!;
                widget.req.sort = sortMap[dropdownvalue];
                if (initial == "desc") {
                  widget.req.sort = "-${widget.req.sort}";
                }
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchSubmitted(req: widget.req));
              }
            });
          },
        ),
        SizedBox(
          width: width * 0.03,
        ),
        DropdownButton<String>(
          value: initial,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: ascOrDesc.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Center(
                child: Text(
                  item,
                  style: item == initial
                      ? MicroYelpText.selectedDropdown
                      : MicroYelpText.activitiesTitle,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              if (initial != newValue) {
                initial = newValue!;
                if (initial == "desc") {
                  widget.req.sort = "-${dropdownvalue.toLowerCase()}";
                } else {
                  widget.req.sort = dropdownvalue.toLowerCase();
                }
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchSubmitted(req: widget.req));
              }
            });
          },
        ),
      ],
    );
  }
}
