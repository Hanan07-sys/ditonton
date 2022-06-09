import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tvseries_watchlist.dart';
import 'package:ditonton/presentation/bloc_tv_series/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListTvSeries,
  GetTvSeriesWatchListStatus,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist,
])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchListTvSeriesStatus mockGetWatchListTvSeriesStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchListTvSeriesStatus = MockGetWatchListTvSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
      mockGetWatchlistTvSeries,
      mockGetWatchListTvSeriesStatus,
      mockRemoveWatchlistTvSeries,
      mockSaveWatchlistTvSeries,
    );
  });

  final tId = 1;

  final testTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
    episodeRunTime: [42],
    genres: [Genre(id: 18, name: 'Drama')],
    homepage: "https://www.telemundo.com/shows/pasion-de-gavilanes",
    id: 1,
    name: "name",
    numberOfEpisodes: 259,
    numberOfSeasons: 2,
    originalName: "Pasión de gavilanes",
    overview: "overview",
    popularity: 1747.047,
    posterPath: "posterPath",
    seasons: [
      Season(
        episodeCount: 188,
        id: 72643,
        name: "Season 1",
        overview: "",
        posterPath: "/elrDXqvMIX3EcExwCenQMVVmnvd.jpg",
        seasonNumber: 1,
      )
    ],
    status: "Returning Series",
    type: "Scripted",
    voteAverage: 7.6,
    voteCount: 1803,
  );

  final tTvSeries = TvSeries(
    backdropPath: "/9hp4JNejY6Ctg9i9ItkM9rd6GE7.jpg",
    firstAirDate: "1997-09-13",
    genreIds: [10764],
    id: 12610,
    name: "Robinson",
    originCountry: ["SE"],
    originalLanguage: "sv",
    originalName: "Robinson",
    overview:
    "Expedition Robinson is a Swedish reality television program in which contestants are put into survival situations, and a voting process eliminates one person each episode until a winner is determined. The format was developed in 1994 by Charlie Parsons for a United Kingdom TV production company called Planet 24, but the Swedish debut in 1997 was the first production to actually make it to television.",
    popularity: 2338.977,
    posterPath: "/sWA0Uo9hkiAtvtjnPvaqfnulIIE.jpg",
    voteAverage: 5,
    voteCount: 3,
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('bloc watch list tv series testing', () {
    test('initial state should be empty', () {
      expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesEmpty());
    });

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
        return OnWatchlistTvSeries().props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTvSeriesLoading(),
    );
  });

  group('bloc status watch list tv series testing', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchListTvSeriesStatus.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvSeries(tId)),
      expect: () => [InsertWatchlist(true)],
      verify: (bloc) {
        verify(mockGetWatchListTvSeriesStatus.execute(tId));
        return WatchlistTvSeries(tId).props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchListTvSeriesStatus.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvSeries(tId)),
      expect: () => [InsertWatchlist(false)],
      verify: (bloc) => WatchlistTvSeriesLoading(),
    );
  });

  group('bloc add watch list tv series testing', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistTvSeries(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        MessageWatchlist('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        return InsertWatchlistTvSeries(testTvSeriesDetail).props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
                (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistTvSeries(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => InsertWatchlistTvSeries(testTvSeriesDetail),
    );
  });

  group('bloc remove watch list tv series testing', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistTvSeries(testTvSeriesDetail)),
      expect: () => [
        MessageWatchlist('Delete to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
        return DeleteWatchlistTvSeries(testTvSeriesDetail).props;
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistTvSeries(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvSeriesError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteWatchlistTvSeries(testTvSeriesDetail),
    );
  });
}