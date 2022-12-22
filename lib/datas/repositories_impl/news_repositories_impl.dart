import 'package:arunafluttertestcodefatur/datas/models/news_model.dart';

import '../../injection_container.dart';
import '../datasources/remote/news_remote_data_source.dart';
import '../repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDatasource = sl<NewsRemoteDataSourceImpl>();

  @override
  Future<List<NewsModel>> getNews({String? search}) async {
    return remoteDatasource.getNews(search: search);
  }
}
