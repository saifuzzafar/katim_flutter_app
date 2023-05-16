import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:katim_app/core/navigation/app_router.dart';
import 'package:katim_app/data/datasource/local/db_constants.dart';
import 'package:katim_app/data/datasource/local/local_datasource.dart';
import 'package:katim_app/data/datasource/remote/remote_datasource.dart';
import 'package:katim_app/data/repository/events_repository_impl.dart';
import 'package:katim_app/domain/usecases/check_if_favourite_usecase.dart';
import 'package:katim_app/domain/usecases/get_events_usecase.dart';
import 'package:katim_app/domain/usecases/remove_from_favourites_usecase.dart';
import 'package:katim_app/domain/usecases/save_to_favourites_usecase.dart';
import 'package:katim_app/presentation/features/event_details/favorite_widget/favorite_data_provider.dart';
import 'package:katim_app/presentation/features/event_list/event_list_data_provider.dart';
import 'package:katim_app/presentation/features/event_list/event_listing_page.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  // Initialize Hive
  await Hive.initFlutter();
  final favoritesBox = await Hive.openBox(DbConstants.favoriteBox);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    // statusBarColor: Colors.red,
    //statusBarBrightness: Brightness.dark
  ));

  runApp(MultiProvider(providers: [
    Provider(
      create: (context) => RemoteDataSource(http.Client()),
    ),
    Provider(
      create: (context) => LocalDataSource(favoritesBox),
    ),
    Provider(
      create: (context) => EventsRepositoryImp(
          context.read<RemoteDataSource>(), context.read<LocalDataSource>()),
    ),
    Provider(
      create: (context) =>
          GetEventsUseCase(context.read<EventsRepositoryImp>()),
    ),
    Provider(
      create: (context) =>
          SaveToFavouritesUseCase(context.read<EventsRepositoryImp>()),
    ),
    Provider(
      create: (context) =>
          RemoveFromFavouritesUseCase(context.read<EventsRepositoryImp>()),
    ),
    Provider(
      create: (context) =>
          CheckIfFavouriteUseCase(context.read<EventsRepositoryImp>()),
    ),
    ChangeNotifierProvider(
      create: (context) => EventListDataProvider(
          context.read<GetEventsUseCase>(),
          context.read<CheckIfFavouriteUseCase>()),
    ),
    ChangeNotifierProvider(
      create: (context) => FavoriteDataProvider(
          context.read<SaveToFavouritesUseCase>(),
          context.read<RemoveFromFavouritesUseCase>(),
          context.read<CheckIfFavouriteUseCase>()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        // maxWidth: 1400,
        minWidth: 375,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(375, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1100, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1100, name: DESKTOP),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(1100, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      home: const EventListingPage(),
    );
  }
}
