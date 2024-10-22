part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

class viewData extends NewsState {
  final Newsapi data;
  viewData({required this.data});
}
