import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:micro_yelp/core/utils/utils_index.dart';

import '../../../authentication/data/authentication_data.dart';
import '../../../features.dart';
import '../../../home/presentation/widgets/error.dart';
import 'reviewer_profile_bloc/reviewer_profile_bloc.dart';
import 'widgets/reviewer_card.dart';
import 'package:iconify_flutter/icons/carbon.dart';

class ReviewerProfilePage extends StatefulWidget {
  const ReviewerProfilePage({Key? key}) : super(key: key);
  static const String route = "/ReviewerProfilePage";

  @override
  State<ReviewerProfilePage> createState() => _ReviewerProfilePageState();
}

class _ReviewerProfilePageState extends State<ReviewerProfilePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) =>
          ReviewerProfileBloc(ReviewerProfileRepository(ReviewerDataProvider()))
            ..add(LoadProfile()),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.only(
              top: heightCalculator(screenHeight: screenHeight, height: 67),
              left: widthCalculator(screenWidth: screenWidth, width: 26),
              right: widthCalculator(screenWidth: screenWidth, width: 26),
            ),
            //The parent of the whole page
            child: BlocBuilder<ReviewerProfileBloc, ReviewerProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProfileLoaded) {
                  //TODO: change the backup profile image
                  ImageProvider image = const AssetImage(
                    MicroYelpImage.userBackupImage ,
                  );
                  if (state.profileInfo.profile.photos.isNotEmpty) {
                    image = NetworkImage(state.profileInfo.profile.photos[0]);
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
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
                                                        child:
                                                            InteractiveViewer(
                                                          child:
                                                              GestureDetector(
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
                                      radius: 50, backgroundImage: image),
                                ),
                                SizedBox(
                                    height: heightCalculator(
                                        screenHeight: screenHeight,
                                        height: 10)),
                                GestureDetector(
                                  onTap: () async {
                                    await StorageService.deleteUser();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    );
                                  },
                                  child: SizedBox(
                                      child: Row(children: [
                                    Text("Log out",
                                        style: MicroYelpText.profileText),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Iconify(Carbon.logout,
                                        color: MicroYelpColor
                                            .primaryColor) // widget,
                                  ])),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${state.profileInfo.profile.firstName} ${state.profileInfo.profile.lastName}',
                                    style: MicroYelpText.profileName),
                                SizedBox(
                                    height: heightCalculator(
                                        screenHeight: screenHeight, height: 3)),
                                SizedBox(
                                  child: Text(
                                    state.profileInfo.profile.email,
                                    style: MicroYelpText.profileBio,
                                  ),
                                ),
                                SizedBox(
                                    height: heightCalculator(
                                        screenHeight: screenHeight, height: 3)),
                                Row(
                                  children: [
                                    state.profileInfo.profile.address.length !=
                                            0
                                        ? Icon(
                                            Icons.location_on,
                                            size: heightCalculator(
                                                screenHeight: screenHeight,
                                                height: 10),
                                          )
                                        : Text(''),
                                    SizedBox(
                                        child: Text(
                                            state.profileInfo.profile.address,
                                            style: MicroYelpText.profileBio)),
                                  ],
                                ),
                                SizedBox(
                                  height: heightCalculator(
                                      screenHeight: screenHeight, height: 24),
                                ),
                                SizedBox(
                                  width: widthCalculator(
                                      screenWidth: screenWidth, width: 190),
                                  child: Text(
                                    state.profileInfo.profile.bio,
                                    style: MicroYelpText.profileBio,
                                  ),
                                )
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                ReviewerProfileInfo user = ReviewerProfileInfo(
                                  firstName:
                                      state.profileInfo.profile.firstName,
                                  lastName: state.profileInfo.profile.lastName,
                                  photos: state.profileInfo.profile.photos,
                                  address: state.profileInfo.profile.address,
                                  bio: state.profileInfo.profile.bio,
                                  downVotes: 0,
                                  reviews: 0,
                                  email: "",
                                  upVotes: 0,
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditReviewerProfile(
                                                profile: user)));
                              },
                              icon: const Iconify(
                                Carbon.edit,
                                color: MicroYelpColor.iconColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: heightCalculator(
                              screenHeight: screenHeight, height: 23),
                        ),
                        Container(
                          color: MicroYelpColor.inputField,
                          height: heightCalculator(
                              screenHeight: screenHeight, height: 70),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: widthCalculator(
                                    screenWidth: screenWidth, width: 39),
                                right: widthCalculator(
                                    screenWidth: screenWidth, width: 39)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          state.profileInfo.profile.upVotes
                                              .toString(),
                                          style: MicroYelpText.reviewerVote),
                                      Text(
                                        "Upvotes",
                                        style: MicroYelpText.reviewerVoteText,
                                      ),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                    indent: heightCalculator(
                                        screenHeight: screenHeight, height: 10),
                                    endIndent: heightCalculator(
                                        screenHeight: screenHeight, height: 10),
                                    color:
                                        const Color.fromRGBO(217, 217, 217, 1)),
                                SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.profileInfo.profile.downVotes
                                            .toString(),
                                        style: MicroYelpText.reviewerVote,
                                      ),
                                      Text("Downvotes",
                                          style:
                                              MicroYelpText.reviewerVoteText),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                    indent: heightCalculator(
                                        screenHeight: screenHeight, height: 10),
                                    endIndent: heightCalculator(
                                        screenHeight: screenHeight, height: 10),
                                    color: Color.fromRGBO(217, 217, 217, 1)),
                                SizedBox(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.profileInfo.profile.reviews
                                          .toString(),
                                      style: MicroYelpText.reviewerVote,
                                    ),
                                    Text(
                                      "Reviews",
                                      style: MicroYelpText.reviewerVoteText,
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: heightCalculator(
                              screenHeight: screenHeight, height: 40),
                        ),
                        SizedBox(
                          height: heightCalculator(
                              screenHeight: screenHeight, height: 19),
                          child: Text(
                            "Recent activities",
                            style: MicroYelpText.activitiesTitle,
                          ),
                        ),
                        SizedBox(
                          height: heightCalculator(
                              screenHeight: screenHeight, height: 34),
                        ),
                        SizedBox(
                          height: heightCalculator(
                              screenHeight: screenHeight, height: 500),
                          child: ListView.separated(
                            // shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              List<ActivityReview> reviews =
                                  state.profileInfo.reviews;

                              ImageProvider profile_image =
                                  const AssetImage(MicroYelpImage.userBackupImage);

                              if (state.profileInfo.profile.photos.isNotEmpty) {
                                profile_image = NetworkImage(
                                    state.profileInfo.profile.photos[0]);
                              }
                              return ReviewCard(
                                dateTime: DateTime.now(),
                                description: reviews[index].textFeedback,
                                downvote: reviews[index].downVotes,
                                name:
                                    "${reviews[index].reviewerProfile.firstName} ${reviews[index].reviewerProfile.lastName}",
                                profilePic: profile_image,
                                rating: reviews[index].rating,
                                upvote: reviews[index].upVotes,
                                itemPhotos: reviews[index].itemPhotos,
                                voted: reviews[index].voted,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                              height: heightCalculator(
                                  screenHeight: screenHeight, height: 26),
                            ),
                            itemCount: state.profileInfo.reviews.length,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is ProfileFailure) {
                  return Scaffold(body: ErrorPage(onTap: () {}));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
