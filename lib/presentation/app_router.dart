import 'package:flutter/material.dart';
import 'package:qtec_solution/models.dart';
import 'package:qtec_solution/presentation/screens/details_screen.dart';

import 'screens/search_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => const SearchScreen(),
      );
    case '/details':
      Result product = settings.arguments as Result;
      return MaterialPageRoute(
        builder: (_) => DetailsScreen(
          product: product,
        ),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const SearchScreen(),
      );
  }
}
