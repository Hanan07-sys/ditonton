part of 'recommendation_movies_bloc.dart';

abstract class RecommendationMoviesState extends Equatable {
  const RecommendationMoviesState();
  @override
  List<Object> get props => [];
}

class RecommendationMoviesEmpty extends RecommendationMoviesState {
  @override
  List<Object> get props => [];
}

class RecommendationMoviesLoading extends RecommendationMoviesState {
  @override
  List<Object> get props => [];
}

class RecommendationMoviesError extends RecommendationMoviesState {
  String message;
  RecommendationMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationMoviesHasData extends RecommendationMoviesState {
  final List<Movie> result;

  RecommendationMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
