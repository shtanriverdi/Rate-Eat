import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:micro_yelp/features/review/presentation/widgets/crop_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddReviewImageSlider extends StatefulWidget {
  final List photos;
  final int currentIndex;

  AddReviewImageSlider(
      {Key? key, required this.photos, required this.currentIndex})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AddReviewImageSliderState();
  }
}

class _AddReviewImageSliderState extends State<AddReviewImageSlider> {
  @override
  Widget build(BuildContext context) {
    late int current = widget.currentIndex;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          IconButton(
              onPressed: () async {
                File currentImage = widget.photos[current];
                var croppedImage = await CropTheImage.cropImage(currentImage);
                if (croppedImage == null) {
                  return;
                }
                File imageFile = File(croppedImage.path);
                widget.photos[current] = imageFile;
                setState(() {});
              },
              icon: Icon(Icons.crop, color: Colors.red)),
          Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    widthCalculator(screenWidth: width, width: 10))),
            height: 410,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                initialPage: current,
                enableInfiniteScroll: true,
                autoPlay: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                onPageChanged: ((index, reason) {
                  current = index;
                  setState(() {});
                }),
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              items: widget.photos.map((file) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(
                          widthCalculator(screenWidth: width, width: 10))),
                      child: InteractiveViewer(
                        maxScale: 4,
                        minScale: 0.2,
                        child: Image.file(
                            File(
                              file.path,
                            ),
                            fit: BoxFit.cover),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Center(
            child: AnimatedSmoothIndicator(
              activeIndex: current,
              count: widget.photos.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.white,
                dotWidth: 7,
                dotHeight: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
