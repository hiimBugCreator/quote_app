import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_app/feature/quote/bloc/quote_bloc.dart';
import 'package:quote_app/resources/routes_name.dart';

import 'feature/home/ui/home.dart';
import 'feature/quote/ui/quote.dart';

void main() {
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
        homeRoute: (context, state, data) => BeamPage(
            child: HomePage(), title: 'Home', key: ValueKey(homeRoute)),
        quoteRoute: (context, state, data) {
          return BeamPage(
              child: const QuotePage(),
              title: 'Quote',
              popToNamed: homeRoute,
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
      title: 'VCL',
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
    );
  }
}
