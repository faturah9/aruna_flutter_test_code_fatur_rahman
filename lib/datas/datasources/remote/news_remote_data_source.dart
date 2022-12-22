import 'package:arunafluttertestcodefatur/datas/models/news_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews({String? search});
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  static String mainUrl = "https://jsonplaceholder.typicode.com/posts";
  final Dio _dio = Dio();

  @override
  Future<List<NewsModel>> getNews({String? search}) async {
    var params = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    Response response = await _dio.get(mainUrl, queryParameters: params);
    return (response.data as List)
        .map((e) => NewsModel.fromJson(e))
        .where((news) {
      final titleLower = news.title!.toLowerCase();
      final authorLower = news.body!.toLowerCase();
      final searchLower = search!.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }
}
