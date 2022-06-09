part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();
}
class OnQueryChanged extends SearchTvSeriesEvent {
  final String query;

  OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}