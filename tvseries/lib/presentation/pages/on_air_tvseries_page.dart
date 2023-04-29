import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/blocs/on_air/on_air_tvseries_bloc.dart';
import 'package:tvseries/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';

class OnAirTVSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/on-air-tvseries';
  const OnAirTVSeriesPage({Key? key}) : super(key: key);

  @override
  State<OnAirTVSeriesPage> createState() => _OnAirTVSeriesPageState();
}

class _OnAirTVSeriesPageState extends State<OnAirTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<OnAirTVSeriesBloc>().add(const FetchOnAirTVSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnAirTVSeriesBloc, OnAirTVSeriesState>(
          builder: (context, state) {
            if (state is OnAirTVSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnAirTVSeriesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = state.tvSeries[index];
                  return TVSeriesCard(tvSeries: tvseries);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is OnAirTVSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is OnAirTVSeriesEmpty) {
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
