import '../models/news_model.dart';

abstract class NewsRepository {
  Future<List<NewsModel>> getNews({String? search});
}


