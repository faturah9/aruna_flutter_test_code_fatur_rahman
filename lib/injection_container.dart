
import 'package:arunafluttertestcodefatur/blocs/news_bloc/news_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'datas/datasources/remote/news_remote_data_source.dart';
import 'datas/repositories/news_repository.dart';
import 'datas/repositories_impl/news_repositories_impl.dart';

final sl = GetIt.instance;

Future<GetIt> init() async {
  /// Khusus Bloc / Cubit
  if (!sl.isRegistered<NewsCubit>()) {
    sl.registerLazySingleton(() => NewsCubit());
  }


  /// Khusus Repository
   if (!sl.isRegistered<NewsRepository>()) {
    sl.registerLazySingleton(() => NewsRepositoryImpl());
   }


  /// Khusus Data sources
  if (!sl.isRegistered<NewsRemoteDataSource>()) {
    sl.registerLazySingleton(() => NewsRemoteDataSourceImpl());
  }


  /// Khusus Core

  if (!sl.isRegistered<GlobalKey<NavigatorState>>()) {
    sl.registerLazySingleton(() => GlobalKey<NavigatorState>());
  }



  ///Khusus Create DB

  return sl;
}
