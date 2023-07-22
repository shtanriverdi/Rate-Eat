import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/search/utils/helper.dart';
import '../../data/models/search_model.dart';
import '../bloc/categories_bloc_event_state.dart';

class CategoryTag extends StatefulWidget {
  final String tagName;
  final SearchModel req;
  bool isSelected;

  CategoryTag(
      {Key? key,
      required this.tagName,
      required this.req,
      required this.isSelected})
      : super(key: key);

  @override
  State<CategoryTag> createState() => _CategoryTagState();
}

class _CategoryTagState extends State<CategoryTag> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.01, horizontal: width * 0.05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.isSelected
                  ? MicroYelpColor.primaryColor
                  : MicroYelpColor.inputField,
            ),
            child: Text(
              widget.tagName,
              style: MicroYelpText.tagStyle(widget.isSelected),
            ),
          );
        },
      ),
      onTap: () {
        String name = widget.tagName;
        setState(() {
          widget.isSelected = !widget.isSelected;
        });

        if (widget.isSelected) {
          widget.req.categories.add(name);
          widget.req.subCategories.add(name);
          if (widget.req.subCategories.length == 1) {
            widget.req.categories
                .remove(Helper.highLevelCategories[widget.req.highLevelIndex]);
          }
        } else {
          widget.req.subCategories.remove(name);
          widget.req.categories.remove(name);
          if (widget.req.subCategories.isEmpty) {
            widget.req.categories
                .add(Helper.highLevelCategories[widget.req.highLevelIndex]);
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
