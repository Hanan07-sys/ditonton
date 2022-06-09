// Mocks generated by Mockito 5.1.0 from annotations
// in ditonton/test/presentation/bloc_movies/bloc/watchlist_movies_bloc_test.dart.
// Do not manually edit this file.
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/movie.dart' as _i7;
import 'package:ditonton/domain/entities/movie_detail.dart' as _i10;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i3;
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart' as _i4;
import 'package:ditonton/domain/usecases/get_watchlist_status.dart'
as _i8;
import 'package:ditonton/domain/usecases/remove_watchlist.dart' as _i11;
import 'package:ditonton/domain/usecases/save_watchlist.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieRepository_1 extends _i1.Fake implements _i3.MovieRepository {}

/// A class which mocks [GetWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistMovies extends _i1.Mock
    implements _i4.GetWatchlistMovies {
  MockGetWatchlistMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i6.Failure, List<_i7.Movie>>>.value(
              _FakeEither_0<_i6.Failure, List<_i7.Movie>>())) as _i5
          .Future<_i2.Either<_i6.Failure, List<_i7.Movie>>>);
}

/// A class which mocks [GetWatchListMovieStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListMovieStatus extends _i1.Mock
    implements _i8.GetWatchListStatus {
  MockGetWatchListMovieStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_1()) as _i3.MovieRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [SaveWatchlistMovie].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistMovie extends _i1.Mock
    implements _i9.SaveWatchlist{
  MockSaveWatchlistMovie() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_1()) as _i3.MovieRepository);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> execute(
      _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
          returnValue: Future<_i2.Either<_i6.Failure, String>>.value(
              _FakeEither_0<_i6.Failure, String>()))
      as _i5.Future<_i2.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistMovie].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistMovie extends _i1.Mock
    implements _i11.RemoveWatchlist {
  MockRemoveWatchlistMovie() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_1()) as _i3.MovieRepository);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> execute(
      _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
          returnValue: Future<_i2.Either<_i6.Failure, String>>.value(
              _FakeEither_0<_i6.Failure, String>()))
      as _i5.Future<_i2.Either<_i6.Failure, String>>);
}