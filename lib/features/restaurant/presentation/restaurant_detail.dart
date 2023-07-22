import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:micro_yelp/features/restaurant/presentation/restaurant_presentation_index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../item/bloc/item_bloc.dart';
import '../../item/presentation/item_detail.dart';
import '../data/models/restaurant.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'bloc/restaurant_state.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/width_and_height_converter.dart';

class RestaurantDetail extends StatefulWidget {
  static const String route = "/restaurant";

  const RestaurantDetail({super.key});

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  bool isSelectedInfo = true;
  int activeindex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<String> days = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wedsday",
      "Thursday",
      "Friday",
      "Saturday"
    ];
    // List<List<String>> items = [
    //   ["Grub on Special Burger", "270", "Description", "stars"]
    // ];

    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantInitial || state is LoadingRestaurant) {
          // resbloc.add(LoadRestaurantInfo());
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is LoadingSuccessful) {
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                  child: Column(
                children: [
                  ImageCouraselStack(
                      height: height,
                      images: state.restaurant.imagesurl,
                      width: width,
                      restaurant: state.restaurant),
                  SizedBox(
                    height: heightCalculator(
                      screenHeight: height,
                      height: 15,
                    ),
                  ),

                       ...List.generate(state.restaurant.items.length, (index){

                        return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<ItemBloc>(context).add(
                                        ItemLoadEvent(
                                            itemId: state
                                                .restaurant.items[index].id));
                                    Navigator.pushNamed(
                                        context, ItemDetail.route);
                                  },
                                  child: ItemCards(
                                      averageRating: state.restaurant
                                          .items[index].ratingAverage,
                                      title: state.restaurant.items[index].name,
                                      imageUrl: state
                                          .restaurant.items[index].picture[0],
                                      price: state.restaurant.items[index].price
                                              .toString() +
                                          " Birr",
                                      description: state
                                          .restaurant.items[index].description),
                                );
                      },)
                      
                      
                ],
              )),
            ),
          );
        } else {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                //TODO: add the resturant id
                // BlocProvider.of<RestaurantBloc>(context)
                //     .add(LoadRestaurantInfo(id: state.restaurant.id));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: height,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/no_connection.png',
                          height: heightCalculator(
                              screenHeight: height, height: 200),
                          width:
                              widthCalculator(screenWidth: width, width: 500),
                        ),
                        Text(
                          "No internet connection",
                          style: MicroYelpText.infoPhoneTitle,
                        ),
                        Text(
                          "please reload!",
                          style: MicroYelpText.infoPhoneTitle,
                        )
                      ]),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Container buildDayWidget(double height, List<String> days, int index,
      double width, LoadingSuccessful state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: heightCalculator(screenHeight: height, height: 29),
          ),
          Divider(
            indent: 0,
            endIndent: 250,
          ),
          Text(
            days[index],
            style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
                color: const Color.fromRGBO(86, 86, 86, 1)),
          ),
          Divider(
            indent: 0,
            endIndent: 250,
          ),
          SizedBox(
            height: heightCalculator(screenHeight: height, height: 12),
          ),
          Text(
            "Morning",
            style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                color: const Color.fromRGBO(86, 86, 86, 1)),
          ),
          SizedBox(
            height: heightCalculator(screenHeight: height, height: 5),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                convertMinutetoDatetime(state.restaurant.workinghours
                    .workday[index].daytime[0].hours[0]),
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: const Color.fromRGBO(106, 106, 106, 1)),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                "to",
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: const Color.fromRGBO(106, 106, 106, 1)),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                convertMinutetoDatetime(state.restaurant.workinghours
                    .workday[index].daytime[0].hours[1]),
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: const Color.fromRGBO(106, 106, 106, 1)),
              ),
            ],
          ),
          SizedBox(
            height: heightCalculator(screenHeight: height, height: 10),
          ),
          Text(
            "Afternoon",
            style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                color: const Color.fromRGBO(86, 86, 86, 1)),
          ),
          SizedBox(height: heightCalculator(screenHeight: height, height: 5)),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                convertMinutetoDatetime(state.restaurant.workinghours
                    .workday[index].daytime[1].hours[0]),
                style: MicroYelpText.workinghours,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "to",
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: const Color.fromRGBO(106, 106, 106, 1)),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                convertMinutetoDatetime(state.restaurant.workinghours
                    .workday[index].daytime[1].hours[1]),
                style: MicroYelpText.workinghours,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String convertMinutetoDatetime(minutes) {
    final duration = Duration(minutes: minutes);
    final zero = DateTime(0);

    final dateTime = zero.add(duration);

    String hour;
    String minute;

    if (dateTime.hour.toString().length == 1) {
      hour = '0' + dateTime.hour.toString();
    } else {
      hour = dateTime.hour.toString();
    }

    if (dateTime.minute.toString().length == 1) {
      minute = '0' + dateTime.minute.toString();
    } else {
      minute = dateTime.minute.toString();
    }

    return (DateFormat.jm().format(
            DateFormat("hh:mm:ss").parse(hour + ':' + minute + ':' + '00')))
        .toString();
  }

  style(isSelectedInfo) {
    return isSelectedInfo
        ? MicroYelpText.selected
        : MicroYelpText.smallCardTitle;
  }
}

_makingPhoneCall(phone) async {
  var url = Uri.parse("tel:${phone}");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class ImageCouraselStack extends StatefulWidget {
  const ImageCouraselStack({
    Key? key,
    required this.height,
    required this.images,
    required this.width,
    required this.restaurant,
    // required this.activeindex,
  }) : super(key: key);

  final double height;
  final List<String> images;
  final double width;
  final RestaurantDetailModel restaurant;

  // final int activeindex;

  @override
  State<ImageCouraselStack> createState() => _ImageCouraselStackState();
}

class _ImageCouraselStackState extends State<ImageCouraselStack> {
  int activeindex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: heightCalculator(screenHeight: widget.height, height: 550),
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlay: false,
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: ((index, reason) {
                setState(() {
                  activeindex = index;
                });
                // print(index);
              }),
              aspectRatio: 0.5,
              height:
                  heightCalculator(screenHeight: widget.height, height: 320),
            ),
            items: widget.images.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    // width:double.infinity,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(heightCalculator(
                            screenHeight: widget.height, height: 15)),
                        bottomRight: Radius.circular(heightCalculator(
                            screenHeight: widget.height, height: 15))),
                    child: Image.network(
                      i,
                      width: double.infinity,
                      fit: BoxFit.cover,

                      // fit: B,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Positioned(
          top: heightCalculator(screenHeight: widget.height, height: 230),
          left: widthCalculator(screenWidth: widget.width, width: 30),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: MicroYelpColor.appBarBackgroundColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 4,
                    blurRadius: 0.9,
                    offset: const Offset(3, 0), // changes position of shadow
                  ),
                ]),
            padding: EdgeInsets.only(
                left: widthCalculator(screenWidth: widget.width, width: 18),
                right: widthCalculator(screenWidth: widget.width, width: 18),
                top: heightCalculator(screenHeight: widget.height, height: 24),
                bottom:
                    heightCalculator(screenHeight: widget.height, height: 10)),
            height: heightCalculator(screenHeight: widget.height, height: 280),
            width: widthCalculator(screenWidth: widget.width, width: 377),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurant.restaurantName,
                  style: MicroYelpText.internalSubTitle3,
                ),
                SizedBox(
                  height: heightCalculator(screenHeight: widget.height, height: 10),
                ),
                GestureDetector(
                  
                  
                  onTap: () {
                    MapsLauncher.launchCoordinates(
                        widget.restaurant.coordinates[0],
                        widget.restaurant.coordinates[1]);
                  },
                  child: Ink(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Iconify(
                          Ic.outline_location_on,
                          color: Color.fromRGBO(72, 110, 245, 1),
                          size: 18,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          width: widthCalculator(
                              screenWidth: widget.width, width: 250),
                          child: Text(
                            widget.restaurant.address,
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                color: Color.fromRGBO(72, 110, 245, 1)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    _makingPhoneCall(widget.restaurant.phoneNumber);
                  },
                  child: Row(children: [
                    SizedBox(width: 2,),
                    Icon(
                      Icons.phone,
                      color: Color.fromRGBO(72, 110, 245, 1),
                      size: 15,
                    ),
                    const SizedBox(
                          width: 4,
                        ),
                    Text(
                      "+251",
                      style: MicroYelpText.phoneNumberStyle                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.restaurant.phoneNumber.substring(1, 4),
                      style: MicroYelpText.phoneNumberStyle,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.restaurant.phoneNumber.substring(4, 7),
                      style: MicroYelpText.phoneNumberStyle,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.restaurant.phoneNumber
                          .substring(7, widget.restaurant.phoneNumber.length),
                      style: MicroYelpText.phoneNumberStyle,
                    )
                  ]),
                ),
                SizedBox(height: heightCalculator(screenHeight: widget.height, height: 16),),
                 Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Working Hours",
                          style: MicroYelpText.activitiesTitle,
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Row(
                          children: [
                            Text(
                              "Saturday",
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(109, 109, 109, 1)),
                            ),
                            SizedBox(width: 85),
                            Text(
                              "Monday to Friday",
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(109, 109, 109, 1)),
                            ),
                          ],
                        ),
                        SizedBox(height: heightCalculator(screenHeight: widget.height, height: 6,)),
                        Row(
                          children: [
                            Text(widget.restaurant.saturday, style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(158, 158, 158, 1)),),
                            SizedBox(width: widthCalculator(screenWidth: widget.width, width: 40),),
                            Text(widget.restaurant.weekdays, style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(158, 158, 158, 1)),),
                          ],
                        ),
                        SizedBox(height: heightCalculator(screenHeight: widget.height, height: 9),),
                        Text("Sunday", style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(109, 109, 109, 1)),),
                        SizedBox(height: heightCalculator(screenHeight: widget.height, height: 9),),

                        Text(widget.restaurant.sunday, style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(158, 158, 158, 1)),),

                                  
                      ],
                    ),
              ],
            ),
          ),
        ),
        Positioned(
          top: heightCalculator(screenHeight: widget.height, height: 210),
          // left: widthCalculator(screenWidth: width, width: 160),
          child: Center(
            child: AnimatedSmoothIndicator(
              activeIndex: activeindex,
              count: widget.images.length,
              effect: const ExpandingDotsEffect(
                dotColor: Colors.white,
                activeDotColor: MicroYelpColor.primaryColor,
                dotWidth: 8,
                dotHeight: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
