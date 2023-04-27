import 'package:core/core.dart';
import 'package:ditonton/presentation/tvseries/provider/on_air_tvseries_notifier.dart';
import 'package:ditonton/presentation/tvseries/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnAirTVSeriesPage extends StatefulWidget {
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
        Provider.of<OnAirTVSeriesNotifier>(context, listen: false)
            .fetchOnAirTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnAirTVSeriesNotifier>(
          builder: (context, data, child) {
            if (data.onAirState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.onAirState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = data.onAirTVSeries[index];
                  return TVSeriesCard(tvSeries: tvseries);
                },
                itemCount: data.onAirTVSeries.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
