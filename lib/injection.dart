import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tvseries_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tvseries_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:ditonton/presentation/bloc_movies/detail_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_movies/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_movies/recommendation_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_movies/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_movies/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_movies/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_tv_series/airing_today_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc_tv_series/detail_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc_tv_series/recommendation_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc_tv_series/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc_tv_series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc_tv_series/watchlist_tv_series_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
        () => SearchMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => NowPlayingMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => DetailMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => RecommendationMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistMoviesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  //bloc tv series
  locator.registerFactory(
        () => SearchTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => AiringTodayTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => PopularTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => DetailTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => RecommendationTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistTvSeriesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // use case
  //MOVIE
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //TVSERIES
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchListTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
        () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
          () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
          () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
