import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/blocs/top_rated/top_rated_tvseries_bloc.dart';
import 'package:tvseries/presentation/widgets/tvseries_card_list.dart';

class TopRatedTVSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/top-rated-tvseries';
  const TopRatedTVSeriesPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTVSeriesPage> createState() => _TopRatedTVSeriesPageState();
}

class _TopRatedTVSeriesPageState extends State<TopRatedTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<TopRatedTVSeriesBloc>()
        .add(const FetchTopRatedTVSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
          builder: (context, state) {
            if (state is TopRatedTVSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTVSeriesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = state.tvSeries[index];
                  return TVSeriesCard(tvSeries: tvseries);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is TopRatedTVSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is TopRatedTVSeriesEmpty) {
              return const Center(
                key: Key('empty_message'),
                child: Text('Tidak ada data'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
