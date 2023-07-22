import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/review/presentation/widgets/add_review_image_slider.dart';
import 'package:micro_yelp/features/review/presentation/widgets/crop_image.dart';
import 'package:micro_yelp/features/review/review.dart';

class AddReview extends StatefulWidget {
  String itemId;
  ImageProvider imageProvider;
  String name;
  String description;
  AddReview(
      {required this.itemId,
      required this.imageProvider,
      required this.name,
      required this.description});
  static const String route = "/add_review";

  @override
  State<AddReview> createState() => _AddReviewState(
      itemId: itemId,
      imageProvider: imageProvider,
      name: name,
      description: description);
}

class _AddReviewState extends State<AddReview> {
  String itemId;
  ImageProvider imageProvider;
  String name;
  String description;
  _AddReviewState(
      {required this.itemId,
      required this.imageProvider,
      required this.name,
      required this.description});
  double ratingController = 3;

  TextEditingController reviewController = TextEditingController();
  List<File> imageFileList = [];
  List<File> tempFileList = [];
  AddReviewRepository addReviewRepository =
      AddReviewRepository(AddReviewDataProvider());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: DismissKeyboard(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: heightCalculator(screenHeight: height, height: 50),
                  horizontal: widthCalculator(screenWidth: width, width: 40)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(children: [
                            const Iconify(
                              Ic.baseline_arrow_back_ios_new,
                              size: 12,
                            ),
                            SizedBox(
                              width: widthCalculator(
                                  screenWidth: width, width: 16),
                            ),
                            Text("Back", style: MicroYelpText.back),
                          ]),
                        ),
                        SizedBox(
                          width: widthCalculator(screenWidth: width, width: 41),
                        ),
                        Text("Add Review", style: MicroYelpText.titleOfPage),
                      ],
                    ),
                    SizedBox(
                      height:
                          heightCalculator(screenHeight: height, height: 30),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              widthCalculator(screenWidth: width, width: 10))),
                      child: Card(
                        elevation: 0,
                        color: MicroYelpColor.inputField,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (BuildContext context) {
                                          return Hero(
                                              tag: "preview",
                                              child: Scaffold(
                                                body: SafeArea(
                                                  child: Center(
                                                    child: InteractiveViewer(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .black54,
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ));
                                        }));
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      widthCalculator(
                                          screenWidth: width, width: 10)),
                                  child: Container(
                                    height: heightCalculator(
                                        screenHeight: height, height: 74),
                                    width: widthCalculator(
                                        screenWidth: width, width: 74),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider)),
                                  )),
                            ),
                            SizedBox(
                              width: widthCalculator(
                                  screenWidth: width, width: 10),
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: MicroYelpText.internalSubTitle,
                                  ),
                                  Text(
                                    description,
                                    style: MicroYelpText.watermark,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: heightCalculator(
                                  screenHeight: height, height: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height:
                          heightCalculator(screenHeight: height, height: 20),
                    ),
                    Divider(
                      thickness:
                          heightCalculator(screenHeight: height, height: 2),
                      indent: widthCalculator(screenWidth: width, width: 30),
                      endIndent: widthCalculator(screenWidth: width, width: 30),
                      color: MicroYelpColor.greyBorder,
                      height:
                          heightCalculator(screenHeight: height, height: 20),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Your overall rating of this dish",
                            style: MicroYelpText.watermark,
                          ),
                          RatingBar.builder(
                            itemSize: 20,
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(
                                horizontal: widthCalculator(
                                    screenWidth: width, width: 4)),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: MicroYelpColor.primaryColor,
                            ),
                            onRatingUpdate: (rating) {
                              ratingController = rating;
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height:
                          heightCalculator(screenHeight: height, height: 30),
                    ),
                    Text(
                      "Add photo",
                      style: MicroYelpText.smallCardTitle,
                    ),
                    SizedBox(
                      height: heightCalculator(screenHeight: height, height: 5),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: MicroYelpColor.inputField,
                            borderRadius: BorderRadius.circular(widthCalculator(
                                screenWidth: width, width: 10))),
                        height:
                            heightCalculator(screenHeight: height, height: 74),
                        width: widthCalculator(screenWidth: width, width: 350),
                        child: const Center(
                          child: Iconify(
                            Mdi.image_plus,
                            color: Color.fromRGBO(204, 204, 204, 1),
                          ),
                        ),
                      ),
                      onTap: () async {
                        tempFileList = (await showModalBottomSheet<List<File>>(
                          backgroundColor: MicroYelpColor.secondaryColor,
                          context: context,
                          builder: (BuildContext context) {
                            return Scaffold(
                              body: BottomSheetContent(
                                currentFileList: imageFileList,
                              ),
                            );
                          },
                        ))!;
                        if (tempFileList == null) {
                          imageFileList = imageFileList;
                        } else {
                          imageFileList = tempFileList;
                        }
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height:
                          heightCalculator(screenHeight: height, height: 45),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageFileList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              await showDialog(
                                barrierColor: Color.fromARGB(105, 0, 0, 0),
                                context: context,
                                builder: (_) => AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.zero,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(widthCalculator(
                                          screenWidth: width, width: 10)),
                                    ),
                                  ),
                                  content: Builder(builder: (context) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.black.withOpacity(.3),
                                        height: height,
                                        width: width,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.2,
                                              left: width * 0.04,
                                              right: width * 0.04),
                                          child: Center(
                                            child: AddReviewImageSlider(
                                              photos: imageFileList,
                                              currentIndex: index,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(heightCalculator(
                                  screenHeight: height, height: 5)),
                              height: heightCalculator(
                                  screenHeight: height, height: 35),
                              width: widthCalculator(
                                  screenWidth: width, width: 35),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    widthCalculator(
                                        screenWidth: width, width: 5),
                                  ),
                                ),
                                child: Image.file(
                                    File(
                                      imageFileList[index].path,
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      "Write your Review",
                      style: MicroYelpText.smallCardTitle,
                    ),
                    SizedBox(
                      height: heightCalculator(screenHeight: height, height: 5),
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: reviewController,
                        maxLength: 450,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(
                                widthCalculator(screenWidth: width, width: 10)),
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
                    ),
                    SizedBox(
                      height:
                          heightCalculator(screenHeight: height, height: 20),
                    ),
                    BlocConsumer<AddReviewBlocBloc, AddReviewBlocState>(
                        listener: (context, state) {
                      if (state is AddReviewSuccess) {
                        const snackBar = SnackBar(
                          content: Text('Thanks for rating!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return Navigator.pop(context);
                      }
                    }, builder: (context, state) {
                      if (state is AddReviewFailure) {
                        return RoundedButton(
                          buttonText: "Failed! Try again.",
                          onClick: () {
                            final form = _formKey.currentState;
                            if (form != null && form.validate()) {
                              form.save();
                              BlocProvider.of<AddReviewBlocBloc>(context).add(
                                AddReviewEvent(
                                  AddReviewModel(
                                      itemID: itemId,
                                      rating: ratingController,
                                      imageUrl: imageFileList,
                                      textfeedback: reviewController.text),
                                ),
                              );
                            }
                          },
                          buttonColor: MicroYelpColor.primaryColor,
                          textStyle: MicroYelpText.buttonText,
                        );
                      } else if (state is AddReviewupLoading) {
                        return Container(
                          height: height * 0.07,
                          width: double.maxFinite,
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        MicroYelpColor.primaryColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Center(
                                  child: CircularProgressIndicator())),
                        );
                      }
                      return RoundedButton(
                        buttonText: "Submit Review",
                        onClick: () {
                          final form = _formKey.currentState;
                          if (form != null && form.validate()) {
                            form.save();
                            BlocProvider.of<AddReviewBlocBloc>(context).add(
                              AddReviewEvent(
                                AddReviewModel(
                                    itemID: itemId,
                                    rating: ratingController,
                                    imageUrl: imageFileList,
                                    textfeedback: reviewController.text),
                              ),
                            );
                          }
                        },
                        buttonColor: MicroYelpColor.primaryColor,
                        textStyle: MicroYelpText.buttonText,
                      );
                    }),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
