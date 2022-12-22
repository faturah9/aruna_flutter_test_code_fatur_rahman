import 'package:arunafluttertestcodefatur/datas/repositories_impl/news_repositories_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../datas/models/news_model.dart';
import '../../datas/models/result_model.dart';
import '../../datas/repositories/news_repository.dart';
import '../../injection_container.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  int? page;
  final NewsRepository _newsRepo = sl<NewsRepositoryImpl>();

  NewsCubit() : super(const NewsState());

  void init() {
    emit(const NewsState());
    getNews();
  }

  void getNews({
    String? search,}) async {
    try {
      emit(state.copyWith(
        newsList: ResultModel.loading(state.newsList?.data),
      ));

      List<NewsModel> news = [];

      final response = await _newsRepo.getNews(search: search);
      news.addAll(response);
      emit(state.copyWith(
        newsList: ResultModel.completed(news),
      ));
    } catch (e) {
      emit(state.copyWith(
        newsList: ResultModel.error(e.toString()),
      ));
    }
  }
}
