import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselWithIndicatorDemo extends StatefulWidget {
  final List<String> photos;

  CarouselWithIndicatorDemo({Key? key, required this.photos}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            // color: Colors.red,
            height: 410,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                enableInfiniteScroll: true,
                autoPlay: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                onPageChanged: ((index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              items: widget.photos.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Center(
            child: AnimatedSmoothIndicator(
              activeIndex: _current,
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
