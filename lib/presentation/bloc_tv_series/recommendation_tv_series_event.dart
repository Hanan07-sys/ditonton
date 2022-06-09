part of 'recommendation_tv_series_bloc.dart';

abstract class RecommendationTvSeriesEvent extends Equatable {
  const RecommendationTvSeriesEvent();
}
class OnRecommendationTvSeriesShow extends RecommendationTvSeriesEvent {
  final int id;

  OnRecommendationTvSeriesShow(this.id);

  @override
  List<Object?> get props => [];
}