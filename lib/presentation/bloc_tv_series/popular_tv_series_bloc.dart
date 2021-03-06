import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTv _getPopularTvSeries;

  PopularTvSeriesBloc(this._getPopularTvSeries) : super(PopularTvSeriesEmpty()) {
    on<OnPopularTvSeriesShow>((event, emit) async {
      emit(PopularTvSeriesLoading());
      final result = await _getPopularTvSeries.execute();

      result.fold(
            (failure) {
          emit(PopularTvSeriesError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(PopularTvSeriesEmpty());
          } else {
            emit(PopularTvSeriesHasData(data));
          }
        },
      );
    });
  }
}
