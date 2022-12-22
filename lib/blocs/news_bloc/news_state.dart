part of 'news_cubit.dart';

@immutable
class NewsState {
  final ResultModel<List<NewsModel>>? newsList;
  final String sorting;

  const NewsState({
    this.newsList,
    this.sorting = 'DESC',
});

  NewsState copyWith({
    ResultModel<List<NewsModel>>? newsList,
    String? sorting,
  }) {
    return NewsState(
      newsList: newsList ?? this.newsList,
      sorting: sorting ?? this.sorting,
    );
  }
}