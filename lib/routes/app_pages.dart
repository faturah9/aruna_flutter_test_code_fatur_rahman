import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/home_page/home_page.dart';
import '../pages/news_detail_page/news_detail_page.dart';
import '../pages/undefined_route/undefined_route_page.dart';

part 'app_routes.dart';

class AppPages {
  static const initialPAGE = Routes.homePAGE;

  static Route<dynamic> generateRoute(final RouteSettings settings) {
    ///arguments digunakan jika dari page 1 ke page lain melempar data
    final arguments =
        (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;

    return CupertinoPageRoute(
      builder: (context) {
        switch (settings.name) {
          case Routes.homePAGE:
            return const HomePage();
          case Routes.newsDETAILPAGE:
            return NewsDetailPage(
              arguments: arguments,
            );
        }

        return UndefinedRoutePage(settings.name ?? '');
      },
    );
  }
}
