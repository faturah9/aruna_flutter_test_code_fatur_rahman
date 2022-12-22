import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blocs/news_bloc/news_cubit.dart';
import 'injection_container.dart';
import 'routes/app_pages.dart';
import 'injection_container.dart' as get_it;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await get_it.init();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getProviders(),
      child: MaterialApp(
        title: 'Code Test Aruna Flutter',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Color(0xFF525252),
            ),
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color(0xFF525252),
            ),
          ),
        ),
        onGenerateRoute: AppPages.generateRoute,
        initialRoute: AppPages.initialPAGE,
        navigatorKey: get_it.sl<GlobalKey<NavigatorState>>(),
      ),
    );
  }

  List<BlocProvider> _getProviders() => [
        BlocProvider<NewsCubit>(
          create: (context) => get_it.sl<NewsCubit>(),
        ),
      ];
}
