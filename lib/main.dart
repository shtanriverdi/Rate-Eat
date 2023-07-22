import 'package:flutter/material.dart';
import 'package:micro_yelp/features/authentication/data/repository/auth_repository.dart';
import 'package:micro_yelp/features/authentication/presentation/login_bloc/login_bloc.dart';
import 'package:micro_yelp/features/features.dart';
import 'package:micro_yelp/features/home/presentation/bloc/home_bloc.dart';
import 'package:micro_yelp/features/home/presentation/screens/home_page_navigator.dart';
import 'package:micro_yelp/features/item/bloc/item_bloc.dart';
import 'package:micro_yelp/features/search/presentation/bloc/bloc/distance_handler_bloc.dart';
import 'package:micro_yelp/routes.dart';
import 'core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/data/authentication_data.dart';
import 'features/profile/presentation/reviewer/reviewer_profile_bloc/reviewer_profile_bloc.dart';
import 'features/restaurant/restaurant.dart';
import 'features/review/data/data_provider/add_review_data_provider.dart';
import 'features/review/data/repository/add_review_repository.dart';
import 'features/review/presentation/bloc/bloc/add_review_bloc_bloc.dart';
import 'features/search/data/datasource/search_data_provider.dart';
import 'features/search/data/models/search_model.dart';
import 'features/search/data/repository/search_repository.dart';
import 'features/search/presentation/bloc/search_bloc.dart';
import 'features/search/presentation/bloc/search_event.dart';
import 'features/search/utils/helper.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  final showHome = await StorageService.hasOpend();
  final token = await StorageService.getToken();
  final bool isLoggedIn = !(token == null);
  runApp(MyApp(showHome: showHome, isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  final bool isLoggedIn;

  final req =
      SearchModel(name: "", categories: <String>{}, subCategories: <String>{});

  final authRepository = AuthRepository();
  final addReviewRepository = AddReviewRepository(AddReviewDataProvider());
  final SearchRepository searchRepository =
      SearchRepository(searchDataProvider: SearchDataProvider());

  MyApp({Key? key, required this.showHome, required this.isLoggedIn})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authRepository: authRepository),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(authRepository: authRepository),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<DistanceHandlerBloc>(
          create: (context) => DistanceHandlerBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(searchRepository: searchRepository)
            ..add(
              SearchSubmitted(req: req),
            ),
        ),
        BlocProvider<AddReviewBlocBloc>(
            create: (context) => AddReviewBlocBloc(addReviewRepository)),
        BlocProvider<ItemBloc>(create: (context) => ItemBloc()),
        BlocProvider<RestaurantBloc>(create: (context) => RestaurantBloc()),
        BlocProvider<ReviewerProfileBloc>(
          create: (context) => ReviewerProfileBloc(
              ReviewerProfileRepository(ReviewerDataProvider())),
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: PageScrollBehavior(),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'Micro Yelp App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          sliderTheme: Helper.sliderTheme,
        ),
        // home: const SearchPage(),
        initialRoute: showHome
            ? (isLoggedIn ? HomePageNavigator.route : LoginPage.route)
            : OnboardingPages.route,
        onGenerateRoute: PageRouter.generateRoute,
      ),
    );
  }
}
