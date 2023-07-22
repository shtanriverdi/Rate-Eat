import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/el.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:image_picker/image_picker.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/review/presentation/widgets/add_review_image_slider.dart';

class BottomSheetContent extends StatefulWidget {
  final List currentFileList;
  const BottomSheetContent({Key? key, required this.currentFileList})
      : super(key: key);

  @override
  State createState() =>
      _BottomSheetContentState(currentFileList: currentFileList);
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  List currentFileList;
  String upload = "Upload";
  _BottomSheetContentState({required this.currentFileList});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
          left: widthCalculator(screenWidth: width, width: 25),
          bottom: heightCalculator(screenHeight: height, height: 33)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            widthCalculator(screenWidth: width, width: 25),
          ),
        ),
      ),
      height: heightCalculator(screenHeight: height, height: 638),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: heightCalculator(screenHeight: width, height: 32),
            ),
            Center(
              child: Text(
                'Upload multiple images',
                style: MicroYelpText.internalSubTitle,
              ),
            ),
            SizedBox(
              height: heightCalculator(screenHeight: height, height: 20),
            ),
            Expanded(
                child: GridView.builder(
                    itemCount: currentFileList.length + 2,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: heightCalculator(
                                      screenHeight: height, height: 5)),
                              height: heightCalculator(
                                  screenHeight: height, height: 170),
                              width: widthCalculator(
                                  screenWidth: width, width: 120),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    widthCalculator(
                                        screenWidth: width, width: 10),
                                  ),
                                ),
                                child: index == 0
                                    ? addPhoto(width, height)
                                    : index == 1
                                        ? addPhotoFromCamera(width, height)
                                        : GestureDetector(
                                            onTap: () async {
                                              await showDialog(
                                                barrierColor: Color.fromARGB(
                                                    151, 97, 97, 97),
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                          widthCalculator(
                                                              screenWidth:
                                                                  width,
                                                              width: 10)),
                                                    ),
                                                  ),
                                                  content: Builder(
                                                      builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: Colors.black
                                                            .withOpacity(.3),
                                                        height: height,
                                                        width: width,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: height *
                                                                      0.2,
                                                                  left: width *
                                                                      0.04,
                                                                  right: width *
                                                                      0.04),
                                                          child: Center(
                                                            child:
                                                                AddReviewImageSlider(
                                                              photos:
                                                                  currentFileList,
                                                              currentIndex:
                                                                  index - 2,
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
                                            child: Image.file(
                                                File(
                                                  currentFileList[index - 2]
                                                      .path,
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                              )),
                          index > 1
                              ? Positioned(
                                  right: 5.0,
                                  child: InkWell(
                                    child: const Icon(
                                      Icons.remove_circle,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                    onTap: () {
                                      setState(
                                        () {
                                          currentFileList.remove(
                                              currentFileList[index - 2]);
                                        },
                                      );
                                    },
                                  ),
                                )
                              : Container()
                        ],
                      );
                    })),
            RoundedButton(
              buttonColor: MicroYelpColor.primaryColor,
              onClick: () async {
                upload = "Success";
                setState(() {});
                await Future.delayed(const Duration(milliseconds: 100), () {});
                return Navigator.pop(context, currentFileList);
              },
              buttonText: upload,
              textStyle: MicroYelpText.buttonText,
            ),
          ],
        ),
      ),
    );
  }

  // a method to pick photos from a gallery.
  final ImagePicker imagePicker = ImagePicker();
  Future selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    List finalSelectedImages = [];
    for (int i = 0; i < selectedImages!.length; i++) {
      File file = File(selectedImages[i].path);
      finalSelectedImages.add(file);
    }

    setState(() {
      for (int i = 0; i < finalSelectedImages.length; i += 1) {
        if (currentFileList.length >= 5) {
          break;
        }
        currentFileList.add(finalSelectedImages[i]);
      }
    });
  }

  // a method to pick photos from a camera
  Future takeImages() async {
    final XFile? selectedImages = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    List<File> finalSelectedImages = [];
    File file = File(selectedImages!.path);
    finalSelectedImages.add(file);

    setState(() {
      currentFileList.add(finalSelectedImages[0]);
    });
  }

  // a method to show the addphoto from camera
  Widget addPhotoFromCamera(double width, double height) {
    return Container(
      decoration: BoxDecoration(
          color: MicroYelpColor.inputField,
          borderRadius: BorderRadius.all(
            Radius.circular(
              widthCalculator(screenWidth: width, width: 25),
            ),
          )),
      width: widthCalculator(screenWidth: width, width: 120),
      height: heightCalculator(screenHeight: height, height: 160),
      child: IconButton(
        onPressed: () async {
          currentFileList.length < 5
              ? await takeImages()
              : ScaffoldMessenger.of(context).showSnackBar(snack_bar());
          setState(() {});
        },
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera,
              color: MicroYelpColor.blueUploadColor,
              size: widthCalculator(screenWidth: width, width: 40),
            ),
            Text(
              "camera",
              style: MicroYelpText.stylishMicroYelp,
            )
          ],
        ),
      ),
    );
  }

  // a method to show a dialog when the maximum image upload reaches.
  // Future<dynamic> show_dialog() {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: Text(
  //             'You can\'t add more than five images !',
  //             textAlign: TextAlign.center,
  //             style: MicroYelpText.internalSubTitle,
  //           ),
  //         );
  //       });
  // }

  // a method to show the addphoto from gallery
  Widget addPhoto(double width, double height) {
    return Container(
      decoration: BoxDecoration(
          color: MicroYelpColor.inputField,
          borderRadius: BorderRadius.all(
            Radius.circular(
              widthCalculator(screenWidth: width, width: 10),
            ),
          )),
      width: widthCalculator(screenWidth: width, width: 120),
      height: heightCalculator(screenHeight: height, height: 170),
      child: IconButton(
        onPressed: () async {
          currentFileList.length < 5
              ? await selectImages()
              : ScaffoldMessenger.of(context).showSnackBar(snack_bar());
          setState(() {});
        },
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: MicroYelpColor.blueUploadColor,
              size: widthCalculator(screenWidth: width, width: 40),
            ),
            Text(
              "gallery",
              style: MicroYelpText.stylishMicroYelp,
            )
          ],
        ),
      ),
    );
  }

  SnackBar snack_bar() {
    return SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        'You can\'t add more than five images !',
        style:
            MicroYelpText.selected.copyWith(fontSize: 18, color: Colors.black),
      ),
      duration: Duration(seconds: 3),
    );
  }
}
