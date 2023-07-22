import 'package:flutter/material.dart';
import 'package:micro_yelp/features/home/presentation/widgets/single_sub_category.dart';

import '../../../../core/utils/constants.dart';

class SubCategories extends StatefulWidget {
  final List subCategories;

  const SubCategories({
    Key? key,
    required this.subCategories,
  }) : super(key: key);

  @override
  State<SubCategories> createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Widget subCategoriesWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: width * 0.01),
          child: Text(
            "Sub-Categories",
            textAlign: TextAlign.left,
            style: MicroYelpText.smallCardTitle,
          ),
        ),
        SizedBox(height: height * 0.01),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: width * 0.008,
          runSpacing: height * 0.006,
          children: [
            for (var index = 0; index < widget.subCategories.length; ++index)
              SubCategory(
                subCategoryName: widget.subCategories[index],
                isSelected: false,
                index: index,
              )
          ],
        ),
        SizedBox(height: height * 0.01),
      ],
    );
    if (widget.subCategories.isNotEmpty) {
      return subCategoriesWidget;
    }
    return const SizedBox.shrink();
  }
}
