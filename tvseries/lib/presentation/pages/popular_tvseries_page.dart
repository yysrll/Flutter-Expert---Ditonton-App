import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/blocs/popular/popular_tvseries_bloc.dart';
import '../widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';

class PopularTVSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/popular-tvseries';
  const PopularTVSeriesPage({Key? key}) : super(key: key);

  @override
  State<PopularTVSeriesPage> createState() => _PopularTVSeriesPageState();
}

class _PopularTVSeriesPageState extends State<PopularTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PopularTVSeriesBloc>().add(const FetchPopularTVSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVSeriesBloc, PopularTVSeriesState>(
          builder: (context, state) {
            if (state is PopularTVSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTVSeriesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = state.tvSeries[index];
                  return TVSeriesCard(tvSeries: tvseries);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is PopularTVSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is PopularTVSeriesEmpty) {
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
