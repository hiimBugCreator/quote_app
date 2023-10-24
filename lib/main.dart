import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quote_app/feature/quote/bloc/quote_bloc.dart';
import 'package:quote_app/resources/routes_name.dart';

import 'feature/quote/ui/quote.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  await Hive.openBox('favorite_quote');
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<QuoteBloc>(
        create: (_) => QuoteBloc(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    transitionDelegate: const ReverseTransitionDelegate(),
    removeDuplicateHistory: true,
    locationBuilder: RoutesLocationBuilder(
      routes: {
        // homeRoute: (context, state, data) => BeamPage(
        //     child: const HomePage(), title: 'Home', key: ValueKey(homeRoute)),
        quoteRoute: (context, state, data) {
          return BeamPage(
              child: const QuotePage(),
              title: 'Quote',
              key: ValueKey(quoteRoute));
        },
        // '/books/:bookId': (context, state, data) {
        //   // Take the path parameter of interest from BeamState
        //   final bookId = state.pathParameters['bookId']!;
        //   // Collect arbitrary data that persists throughout navigation
        //   final info = (data as MyObject).info;
        //   // Use BeamPage to define custom behavior
        //   return BeamPage(
        //     key: ValueKey('book-$bookId'),
        //     title: 'A Book #$bookId',
        //     popToNamed: '/',
        //     type: BeamPageType.scaleTransition,
        //     child: BookDetailsScreen(bookId, info),
        //   );
        // }
      },
    ),
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
    );
  }
}
