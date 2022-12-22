
import 'package:arunafluttertestcodefatur/blocs/news_bloc/news_cubit.dart';
import 'package:arunafluttertestcodefatur/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> get providers => [
      BlocProvider(create: (_) => sl<NewsCubit>()),
    ];