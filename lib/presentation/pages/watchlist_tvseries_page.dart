
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc_tv_series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist_tvseries';

  @override
  State<WatchlistTvSeriesPage> createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage> with RouteAware{
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistTvSeriesBloc>().add(OnWatchlistTvSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTvSeriesBloc>().add(OnWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
          builder: (context, state) {
            if (state is WatchlistTvSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvSeriesHasData) {
              final result = state.result;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return TvSeriesCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  ),
                ],
              );
            } else if (state is WatchlistTvSeriesEmpty) {
              return Center(
                child: Text("No watch list yet"),
              );
            } else if (state is WatchlistTvSeriesError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text("Error get data watch list"),
              );
            }
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
