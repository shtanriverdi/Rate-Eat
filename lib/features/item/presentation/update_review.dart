import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/authentication/presentation/authentication_presentation_index.dart';
import 'package:micro_yelp/features/item/domain/edit_review.dart';
import 'package:micro_yelp/features/item/presentation/item_detail.dart';

class UpdateReviewPage extends StatefulWidget {
  final String previousText;
  final int previousRating;

  static const String route = "/updateReview";

  const UpdateReviewPage(
      {super.key, required this.previousText, required this.previousRating});

  @override
  State<UpdateReviewPage> createState() => _UpdateReviewPageState();
}

class _UpdateReviewPageState extends State<UpdateReviewPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double ratingController = widget.previousRating.toDouble();
    TextEditingController descriptionController =
        TextEditingController(text: widget.previousText);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                  widthCalculator(screenWidth: width, width: 20)),
              topRight: Radius.circular(
                  widthCalculator(screenWidth: width, width: 20)))),
      padding: EdgeInsets.only(
          left: widthCalculator(screenWidth: width, width: 40),
          right: widthCalculator(screenWidth: width, width: 40),
          top: heightCalculator(screenHeight: height, height: 20),
          bottom: heightCalculator(screenHeight: height, height: 20)),
      child: Wrap(
        children: <Widget>[
          SizedBox(height: heightCalculator(screenHeight: height, height: 22)),
          Center(child: 
          Icon(Icons.horizontal_rule, size: 30,color: MicroYelpColor.bottomNavigationIconColor,)
          ),
          Container(
              alignment: Alignment.bottomLeft,
              child: Center(

                child: Text(
                  'Edit review',
                  style: MicroYelpText.internalSubTitle,
                ),
              )),
          SizedBox(height: heightCalculator(screenHeight: height, height: 22)),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rating', style: MicroYelpText.reviewProfile),
                SizedBox(height: heightCalculator(screenHeight: height, height: 10),),
                RatingBar.builder(
                  itemSize: 25,
                  initialRating: widget.previousRating.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(
                      horizontal:
                          widthCalculator(screenWidth: width, width: 4)),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: MicroYelpColor.primaryColor,
                  ),
                  onRatingUpdate: (rating) {
                    ratingController = rating;
                  },
                ),
                SizedBox(height: heightCalculator(screenHeight: height, height: 35),),
                Text('Description', style: MicroYelpText.reviewProfile),
                SizedBox(height: heightCalculator(screenHeight: height, height: 10),),

                TextFormField(
                  // initialValue: widget.previousText,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(
                          widthCalculator(screenWidth: width, width: 20)),
                    ),
                    fillColor: MicroYelpColor.inputField,
                    filled: true,
                    border: InputBorder.none,
                    hintText:
                        'would you like to write anything about this dish?',
                    hintStyle: MicroYelpText.watermark,
                  ),
                  minLines: 6,
                  maxLines: 20,
                ),
                SizedBox(
                    height: heightCalculator(screenHeight: height, height: 20)),
                Container(
                    child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: RoundedButton(
                      buttonText: "Update Review",
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          validator:
                          (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please write some reviews.';
                            }
                            return null;
                          };
                        }
                        return Navigator.pop(
                            context,
                            EditReview(
                                description: descriptionController.text,
                                rating: ratingController.toString()));
                      },
                      buttonColor: MicroYelpColor.primaryColor,
                      textStyle: MicroYelpText.buttonText),
                )),
                SizedBox(
                    height: heightCalculator(screenHeight: height, height: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
