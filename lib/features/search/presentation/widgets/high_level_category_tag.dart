import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/search/presentation/bloc/categories_bloc_event_state.dart';
import 'package:micro_yelp/features/search/utils/helper.dart';
import '../../data/models/search_model.dart';

class HighLevelCategoryTag extends StatefulWidget {
  final String tagName;
  final SearchModel req;
  Widget iconWidget;
  int ind;
  final elevation;

  HighLevelCategoryTag({
    Key? key,
    required this.tagName,
    required this.req,
    this.iconWidget = const SizedBox(),
    this.elevation = 0.0,
    required this.ind,
  }) : super(key: key);

  @override
  State<HighLevelCategoryTag> createState() => _HighLevelCategoryTagState();
}

class _HighLevelCategoryTagState extends State<HighLevelCategoryTag> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesUpdated) {
            return Container(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.01, horizontal: width * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: MicroYelpColor.greyBorder.withOpacity(0.5),
                    blurRadius: 2,
                    offset: Offset(1, 3), // Shadow position
                  ),
                ],
                color: state.highLevelIndex == widget.ind
                    ? MicroYelpColor.primaryColor
                    : MicroYelpColor.inputField,
              ),
              child: Row(
                children: [
                  state.highLevelIndex == widget.ind
                      ? Helper.enabledIcons[widget.ind]
                      : Helper.disabledIcons[widget.ind],
                  SizedBox(
                    width: width * 0.01,
                  ),
                  Text(
                    widget.tagName,
                    style: MicroYelpText.tagStyle(
                        state.highLevelIndex == widget.ind),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      onTap: () {
        String name = widget.tagName;
        if (widget.req.highLevelIndex == widget.ind) {
          print(
              "**************** High level - selected before ${widget.ind}***********************");
          setState(() {
            widget.req.highLevelIndex = -1;
            widget.req.categories = <String>{};
            widget.req.subCategories = <String>{};
          });
        } else {
          if (widget.req.highLevelIndex != -1) {
            print(
                "**************** High level - something selected before ${widget.ind}***********************");
            setState(() {
              widget.req.categories = <String>{};
              widget.req.subCategories = <String>{};
              widget.req.categories.add(name);
              widget.req.highLevelIndex = widget.ind;
            });
          } else {
            print(
                "**************** High level - nothing selected before ${widget.ind} ${widget.req.highLevelIndex}***********************");
            setState(() {
              widget.req.highLevelIndex = widget.ind;
              widget.req.categories.add(name);
            });
          }
        }
        print(widget.req.categories);
        print("sub " + widget.req.subCategories.toString());
        BlocProvider.of<CategoriesBloc>(context)
            .add(UpdateCategories(highLevelIndex: widget.req.highLevelIndex));
      },
    );
  }
}
