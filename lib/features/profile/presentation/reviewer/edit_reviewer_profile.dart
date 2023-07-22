import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:micro_yelp/features/home/presentation/screens/home_page_navigator.dart';
import 'package:micro_yelp/features/review/presentation/widgets/crop_image.dart';
import '../../profile.dart';
import 'reviewer_profile_bloc/reviewer_profile_bloc.dart';

class EditReviewerProfile extends StatefulWidget {
  final ReviewerProfileInfo profile;

  const EditReviewerProfile({Key? key, required this.profile})
      : super(key: key);
  static const String route = "/editReviewerProfile";

  @override
  State<EditReviewerProfile> createState() => _EditReviewerProfileState();
}

class _EditReviewerProfileState extends State<EditReviewerProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  List<File> imageFileList = [];

  final _formKey = GlobalKey<FormState>();

  var maxLength = 300;
  var textLength = 0;

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.profile.firstName;
    lastNameController.text = widget.profile.lastName;
    addressController.text = widget.profile.address;
    bioController.text = widget.profile.bio;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    ImageProvider image = const AssetImage(
      MicroYelpImage.userBackupImage,
    );
    if (imageFileList.isNotEmpty) {
      image = FileImage(imageFileList[imageFileList.length - 1]);
    } else if (widget.profile.photos.isNotEmpty) {
      image =
          NetworkImage(widget.profile.photos[widget.profile.photos.length - 1]);
    }
    return SafeArea(
      child: DismissKeyboard(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
                left: widthCalculator(screenWidth: width, width: 34),
                right: widthCalculator(screenWidth: width, width: 34)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: heightCalculator(screenHeight: height, height: 40),
                  ),
                  Text(
                    "Edit Profile",
                    style: MicroYelpText.mainTitle,
                  ),
                  SizedBox(
                      height:
                          heightCalculator(screenHeight: height, height: 30)),
                  Row(
                    children: [
                      Stack(
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
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .black54,
                                                            image:
                                                                DecorationImage(
                                                                    image:
                                                                        image)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ));
                                      }));
                            },
                            child: CircleAvatar(
                              radius: 60,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: image,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromRGBO(55, 69, 119, 1),
                              radius: 16,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  _showSelectionDialog(context);
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 32,
                                  color: MicroYelpColor.appBarBackgroundColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                          width:
                              widthCalculator(screenWidth: width, width: 20)),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Upload your Photo",
                              maxLines: 1,
                              style: MicroYelpText.smallCardTitle,
                            ),
                            SizedBox(
                              height: heightCalculator(
                                  screenHeight: height, height: 10),
                            ),
                            Text(
                              "Will be displayed to others as your profile image.",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: MicroYelpText.watermark,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: heightCalculator(screenHeight: height, height: 63),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          hintText: "firstName",
                          icon: const Icon(Icons.person_outline),
                          controller: firstNameController,
                          customHeight: 60,
                          customWidth: 392,
                          textStyle: MicroYelpText.watermark,
                        ),
                        SizedBox(
                            height: heightCalculator(
                                screenHeight: height, height: 10)),
                        CustomTextFormField(
                          hintText: "lastName",
                          icon: const Icon(Icons.person_outline),
                          controller: lastNameController,
                          customHeight: 60,
                          customWidth: 392,
                          textStyle: MicroYelpText.watermark,
                        ),
                        SizedBox(
                            height: heightCalculator(
                                screenHeight: height, height: 10)),
                        CustomTextFormField(
                          hintText: widget.profile.address.isNotEmpty
                              ? widget.profile.address
                              : "Your address",
                          icon: const Icon(Icons.location_on_outlined),
                          controller: addressController,
                          customHeight: 60,
                          customWidth: 392,
                          textStyle: MicroYelpText.watermark,
                        ),
                        SizedBox(
                            height: heightCalculator(
                                screenHeight: height, height: 10)),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          height: heightCalculator(
                              screenHeight: height, height: 120),
                          width:
                              widthCalculator(screenWidth: width, width: 348),
                          child: TextFormField(
                            cursorColor: Colors.red,
                            controller: bioController,
                            maxLength: 300,
                            decoration: InputDecoration(
                              counter: const Offstage(),
                              suffixText:
                                  '${textLength.toString()}/${maxLength.toString()}',
                              fillColor: MicroYelpColor.inputField,
                              filled: true,
                              hintText: widget.profile.bio.isNotEmpty
                                  ? widget.profile.bio
                                  : "write something about your self.",
                              hintStyle: MicroYelpText.watermark,
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      widthCalculator(
                                          screenWidth: width, width: 10))),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: widthCalculator(
                                      screenWidth: width, width: 2),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    widthCalculator(
                                        screenWidth: width, width: 10),
                                  ),
                                ),
                              ),
                            ),
                            maxLines: 6,
                            onChanged: (value) {
                              setState(() {
                                textLength = value.length;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: heightCalculator(screenHeight: height, height: 60),
                  ),
                  BlocListener<ReviewerProfileBloc, ReviewerProfileState>(
                    listener: (context, state) {
                      if (state is ProfileUpdated) {
                        Navigator.popAndPushNamed(
                            context, ReviewerProfilePage.route);
                        // Navigator.pushNamedAndRemoveUntil(context,
                        //     HomePageNavigator.route, (route) => false);
                      } else if (state is ProfileFailure) {
                        Navigator.pop(context);
                      }
                    },
                    child: RoundedButton(
                        buttonText: "Continue",
                        onClick: () {
                          BlocProvider.of<ReviewerProfileBloc>(context).add(
                            ReviewerProfileEdit(
                                ReviewerProfileInfo(
                                  address: addressController.text.isNotEmpty
                                      ? addressController.text
                                      : widget.profile.address,
                                  bio: bioController.text.isNotEmpty
                                      ? bioController.text
                                      : widget.profile.bio,
                                  downVotes: widget.profile.downVotes,
                                  email: widget.profile.email,
                                  firstName: firstNameController.text.isNotEmpty
                                      ? firstNameController.text
                                      : widget.profile.firstName,
                                  lastName: lastNameController.text.isNotEmpty
                                      ? lastNameController.text
                                      : widget.profile.lastName,
                                  photos: widget.profile.photos,
                                  reviews: widget.profile.reviews,
                                  upVotes: widget.profile.upVotes,
                                ),
                                imageFileList),
                          );
                        },
                        buttonColor: MicroYelpColor.primaryColor,
                        textStyle: MicroYelpText.buttonText),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Selection dialog that prompts the user to select an existing photo or take a new one
  Future _showSelectionDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select photo'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('From gallery'),
              onPressed: () {
                selectImages();
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text('Take a photo'),
              onPressed: () {
                takeImages();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // a method to pick photos from a gallery.
  final ImagePicker imagePicker = ImagePicker();
  Future selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      File file = File(selectedImages[0].path);
      // crop image starts here.
      var croppedImage = await CropTheImage.cropImage(file);
      if (croppedImage == null) {
        return;
      }
      File imageFile = File(croppedImage.path);
      imageFileList.add(imageFile);
      // crop image ends here.
    }
    setState(() {});
  }

  // a method to pick photos from a camera
  Future takeImages() async {
    final XFile? selectedImages = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (selectedImages != null) {
      File file = File(selectedImages.path);
      // crop image starts here.
      var croppedImage = await CropTheImage.cropImage(file);
      if (croppedImage == null) {
        return;
      }
      File imageFile = File(croppedImage.path);
      imageFileList.add(imageFile);
      // crop image ends here.
    }
    setState(() {});
  }
}
